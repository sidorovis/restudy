/*
 *  MainWindow.cpp
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 29.10.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#include "MainWindow.h"

const QString MainWindow::myPluginsDir("/Applications/MacPorts/qgis1.3.0.app/Contents/MacOS/lib/qgis");

MainWindow::MainWindow(QWidget* parent) : 
     QMainWindow(parent),
     uiMainWindow(new Ui::MainWindow),
     selected_lay_index( -1 )
{
	uiMainWindow->setupUi(this);
	QgsProviderRegistry::instance(MainWindow::myPluginsDir);
	uiMainWindow->mapWidget->setCanvasColor( QColor(255,255,255) );	
	layerNamesModel = new QStringListModel();
	uiMainWindow->layerList->setModel(layerNamesModel);
	show();	
	addVectorLayer("/Users/rilley_elf/maps/city.mif");
//	addVectorLayer("/Users/rilley_elf/maps/regions.mif");
}
MainWindow::~MainWindow()
{
	uiMainWindow->mapWidget->clear();
	QgsMapLayerRegistry::instance()->removeAllMapLayers();
	delete layerNamesModel;
}
void MainWindow::addVectorLayer(const QString& filePath)
{
	Layer *layer = new Layer(filePath);
	if (layer->isValid())
	{
		QgsMapLayerRegistry::instance()->addMapLayer(layer, TRUE);
		layers.push_back( layer );		
	}
	else
	{
		QMessageBox messageBox;
		messageBox.setText("This file content wrong vector layer");
		messageBox.exec();
	}
	reDraw();
}
void MainWindow::reDraw()
{
	layerNamesModel->setStringList( getLayerNameList( layers ) );
//	uiMainWindow->mapWidget->clear();
	QList<QgsMapCanvasLayer> myLayerSet;
	foreach( Layer* layer, layers)
	if (layer->visible) 
	{
		uiMainWindow->mapWidget->setExtent( layer->extent() );
		myLayerSet.push_back(layer);
	}
	uiMainWindow->mapWidget->setLayerSet( myLayerSet );
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
	searchDialog.exec();
}
