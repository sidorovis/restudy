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
     uiMainWindow(new Ui::MainWindow)
{
	uiMainWindow->setupUi(this);
	setCentralWidget(mapWidget = new QgsMapCanvas(0, 0));
	delete uiMainWindow->centralwidget;
	QgsProviderRegistry::instance(MainWindow::myPluginsDir);
	mapWidget->setCanvasColor(QColor(255,255,255));
//	setCentralWidget( mapWidget );
//	uiMainWindow->scrollAreaWidgetContents->show();
//	
//	addVectorLayer("/Users/rilley_elf/maps/city.mif");
//	addVectorLayer("/Users/rilley_elf/maps/regions.mif");
//	addVectorLayer("/Users/rilley_elf/maps/map.osm.xml");
	
	show();
}

void MainWindow::addVectorLayer(const QString& filePath)
{
//	QString myProviderName = "osm";
	QString myProviderName = "ogr";
	QFileInfo layerFileInfo(filePath);
	QgsVectorLayer* vectorLayer = new QgsVectorLayer(layerFileInfo.filePath(), layerFileInfo.completeBaseName(), myProviderName );
	if (vectorLayer->isValid())
	{
		qDebug("Layer is valid");
	}
	else
	{
		qDebug("Layer is NOT valid");
		return; 
	}
	
	QgsMapLayerRegistry::instance()->addMapLayer(vectorLayer, TRUE);
	
	myLayerSet.push_back(vectorLayer);
	mapWidget->clear();
	mapWidget->setExtent(vectorLayer->extent());
	mapWidget->setLayerSet(myLayerSet);
}
void MainWindow::loadOgrFile()
{
	QFileDialog fileDialog(this, "Choose OGR vector file", "~/", tr("Vector Layer files (*.mif *.map)"));
	fileDialog.setAcceptMode(QFileDialog::AcceptOpen);
	fileDialog.setFileMode(QFileDialog::ExistingFile);
	if (fileDialog.exec())
	{
		qDebug() << fileDialog.selectedFiles();
		addVectorLayer(fileDialog.selectedFiles().at(0));
	}
}
