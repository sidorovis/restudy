/*
 *  MainWindow.cpp
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 29.10.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#include "GISObjectViewerDialog.h"
#include "MainWindow.h"
#include "GISObject.h"

#include "qgis/qgsgeometry.h"
#include "qgis/qgslabel.h"
#include "qgis/qgis.h"
#include "qgis/qgsdistancearea.h"
#include "qgis/qgsapplication.h"
#include "qgis/qgsvectordataprovider.h"

#include <QStatusBar>
#include "DistanceShowDialog.h"
#include "LayerPropertiesDialog.h"
#include "SearchDialog.h"
#include "WGS84Hack.h"

const QString MainWindow::myPluginsDir("/Applications/MacPorts/qgis1.3.0.app/Contents/MacOS/lib/qgis");

MainWindow::MainWindow(QWidget* parent) : 
     QMainWindow(parent),
     uiMainWindow(new Ui::MainWindow),
     selected_lay_index( -1 )
{
	uiMainWindow->setupUi(this);
	QgsProviderRegistry::instance(MainWindow::myPluginsDir);
	uiMainWindow->mapWidget->setCanvasColor( QColor(255,255,255) );	
	tool = new QgsMapToolEmitPoint( uiMainWindow->mapWidget );
	uiMainWindow->mapWidget->setMapTool( tool );
	connect(tool, SIGNAL(canvasClicked(const QgsPoint, Qt::MouseButton)), this, SLOT(mapClicked(const QgsPoint, Qt::MouseButton)));
	layerNamesModel = new QStringListModel();
	uiMainWindow->layerList->setModel(layerNamesModel);
	status = new QLabel();
	uiMainWindow->statusbar->addWidget( status );
	show();	
	addVectorLayer("./maps/city.mif");
	addVectorLayer("./maps/roads.mif", false);
	addVectorLayer("./maps/regions.mif", false);
//	addVectorLayer("./maps/zhd_road.mif");
	
}
MainWindow::~MainWindow()
{
	uiMainWindow->mapWidget->clear();
	QgsMapLayerRegistry::instance()->removeAllMapLayers();
	delete tool;
	delete layerNamesModel;
	delete status;
	delete uiMainWindow;
}
void MainWindow::addVectorLayer(const QString& filePath, bool visible)
{
	Layer *layer = new Layer(filePath);
	if (layer->isValid())
	{
		QgsMapLayerRegistry::instance()->addMapLayer(layer, TRUE);
		layers.push_back( layer );
		layer->visible = visible;
	}
	else
	{
		QMessageBox messageBox;
		messageBox.setText("This file content wrong vector layer");
		messageBox.exec();
	}
	reDraw();
	repaint();
}
void MainWindow::reDraw()
{
	layerNamesModel->setStringList( getLayerNameList( layers ) );
//	uiMainWindow->mapWidget->clear();
	QList<QgsMapCanvasLayer> myLayerSet;
	bool first = false;
	QgsRectangle prevRect = uiMainWindow->mapWidget->extent();
	if (prevRect.xMaximum() == 0 &&
		prevRect.xMinimum() == 0 &&
		prevRect.yMaximum() == 0 &&
		prevRect.yMinimum() == 0)
		first = true;
	foreach( Layer* layer, layers)
	{
		if (layer->visible)
		{
			myLayerSet.push_back(layer);
			if (layer->showLabels && 
				layer->feature_attribute_label_index > -1 && 
				layer->feature_attribute_label_index < layer->dataProvider()->fields().size())
			{
				layer->label()->setLabelField( QgsLabel::Text, layer->feature_attribute_label_index);
				layer->enableLabels( true );
			}
			else
				layer->enableLabels( false );
		}		
	}
	uiMainWindow->mapWidget->setLayerSet( myLayerSet );
	if (first)
		uiMainWindow->mapWidget->zoomToFullExtent();
	else
		uiMainWindow->mapWidget->refresh();
		
}

void MainWindow::loadOgrFile()
{
	QFileDialog fileDialog(this, "Choose OGR vector file", "~/", tr("Vector Layer files (*.mif *.tab)"));
	fileDialog.setAcceptMode(QFileDialog::AcceptOpen);
	fileDialog.setFileMode(QFileDialog::ExistingFile);
	if (fileDialog.exec())
		addVectorLayer(fileDialog.selectedFiles().at(0));
}
void MainWindow::listButtonPressed(const QModelIndex &index)
{
	selected_lay_index = index.row();
	if (QApplication::mouseButtons() == Qt::RightButton)
	{
		LayerPropertiesDialog dialog( layers.at( selected_lay_index ));
		dialog.exec();
		reDraw();
		repaint();
	}
}
void MainWindow::changeLayerOrder(int first, int second)
{
	if (first < layers.size() && second < layers.size())
		layers.swap( first, second );
	reDraw();
}
void MainWindow::upPressed()
{
	if (selected_lay_index > 0)
	{
		changeLayerOrder(selected_lay_index, selected_lay_index - 1);
		selected_lay_index = -1;		
	}
}
void MainWindow::downPressed()
{
	if (selected_lay_index > -1 && selected_lay_index < layers.size() - 1)
	{
		changeLayerOrder(selected_lay_index, selected_lay_index + 1);
		selected_lay_index = -1;		
	}
}
void MainWindow::showSearchDialog()
{
	SearchDialog searchDialog(&layers);
	if (searchDialog.exec())
	{
		QHash< Layer*, QSet<int> > featuresIds;
		foreach(GISObject* obj, searchDialog.selectedObjects())
		{
			featuresIds[ (*obj).parentLayer ] << (*obj).f.id();			
		}
		foreach(Layer* layer, featuresIds.keys())
		{
			foreach(const QgsFeature& f, layer->selectedFeatures())
			{
				featuresIds[ layer ] << f.id();
			}
			layer->setSelectedFeatures( featuresIds[ layer ] );
		}
	}
}
void MainWindow::deleteAllSelections()
{
	foreach(Layer* layer, layers)
		layer->removeSelection();
}
void MainWindow::findDistance()
{
	DistanceShowDialog dialog;
	QStringList headers;
	foreach(Layer* layer, layers)
	{
		foreach(QgsFeature f, layer->selectedFeatures() )
		{
			GISObject* temp = GISObject::generateGISObject( layer, f );
			headers << temp->toSmallString();
			delete temp;			
		}
	}
	if ( headers.size() < MINIMUM_SELECTED_FEATURES_DISTANCE_BETWEEN )
	{
		QMessageBox messageBox(this);
		messageBox.setText("Choose at least two objects.");
		messageBox.exec();
		return;		
	}
	if ( headers.size() > MAXIMUM_SELECTED_FEATURES_DISTANCE_BETWEEN )
	{
		QMessageBox messageBox(this);
		messageBox.setText("This function was not planned for such big count of objects operations. Clean selecting, and try again.");
		messageBox.exec();
		return;
	}
	dialog.setSize( headers.size() );
	dialog.setTitles(headers);
	for(int iL = 0 ; iL < layers.size() ; iL++)
	{
		int layerFromFeatureCount = layers.at(iL)->selectedFeatures().size();
		for ( int i = 0 ; i < layerFromFeatureCount ; i++ )
		{
			for(int uL = 0 ; uL < layers.size() ; uL++)
			{
				int layerToFeatureCount = layers.at(uL)->selectedFeatures().size();
				int u_st;
				if (iL == uL)
					u_st = i + 1;
				else
					u_st = 0;
				for ( int u = u_st ; u < layerToFeatureCount ; u++ )
				{
					QgsPoint pFrom = static_cast<QgsFeature>(layers.at(iL)->selectedFeatures().at(i)).geometry()->centroid()->asPoint();
					QgsPoint pTo = static_cast<QgsFeature>(layers.at(uL)->selectedFeatures().at(u)).geometry()->centroid()->asPoint();
					int ind_1 = (iL*layerFromFeatureCount+i);
					int ind_2 = (uL*layerToFeatureCount+u);
					dialog.setValue(ind_1, ind_2, QString("%1").arg(MyDistanceArea::computeDistanceBearing(pFrom, pTo)));
				}
			}
			
		}
	}
	dialog.exec();
}
void MainWindow::getXYcoordinates(QgsPoint point)
{
	status->setText(QString("%1 %2").arg(point.x()).arg(point.y()));
}
void MainWindow::zoomToFullExtent()
{
	uiMainWindow->mapWidget->zoomToFullExtent();
}
void MainWindow::zoomToNextExtent()
{
	uiMainWindow->mapWidget->zoomToNextExtent();
}
void MainWindow::zoomToPreviousExtent()
{
	uiMainWindow->mapWidget->zoomToPreviousExtent();	
}
void MainWindow::zoomToSelected()
{
	uiMainWindow->mapWidget->zoomToSelected();	
}
void MainWindow::mapClicked(const QgsPoint &point, Qt::MouseButton button)
{
	if (button != Qt::LeftButton)
		return;
	QHash< Layer*, QSet<int> > selectedFIds;
	foreach(Layer* layer, layers)
	{
		foreach(const QgsFeature& f, layer->selectedFeatures())
		{
			selectedFIds[ layer ] << f.id();
		}
		layer->removeSelection();
	}
	QList<GISObject*> objects;
	foreach(Layer* layer, layers)
	{
		if (layer->visible)
		{
			GISObject* object = layer->search( point ); 
			if (object != NULL)
			{
				objects << object;
			}
		}
	}
	if (objects.size() == 0)
		return;
	GISObjectViewerDialog dialog(objects, this);
	dialog.exec();
	foreach(GISObject* obj, objects)
	{
		delete obj;
	}
	foreach(Layer* layer, layers)
	{
		layer->setSelectedFeatures( selectedFIds[ layer ] );
	}
}
