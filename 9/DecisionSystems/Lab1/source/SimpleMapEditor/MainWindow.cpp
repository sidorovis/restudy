/*
 *  MainWindow.cpp
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 29.10.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#include "MainWindow.h"

MainWindow::MainWindow(QWidget* parent) : QMainWindow(parent)
{
	setMinimumSize(minimumX, minimumY);
	mapWidget = new QgsMapCanvas( this );
	setCentralWidget( mapWidget );
	
	addVectorLayer();
	
	show();
}

void MainWindow::addVectorLayer()
{
	QFileInfo layerFileInfo("/Users/rilley_elf/map/city.mif");
	QgsVectorLayer* vectorLayer = new QgsVectorLayer(layerFileInfo.filePath(), layerFileInfo.completeBaseName());
	if (vectorLayer->isValid())
	{
		qDebug("Layer is valid");
	}
	else
	{
		qDebug("Layer is NOT valid");
		return; 
	}
	QList<QgsMapCanvasLayer> myLayerSet;
	
	QgsMapLayerRegistry::instance()->addMapLayer(vectorLayer, TRUE);
	
	myLayerSet.push_back(vectorLayer);
	mapWidget->setExtent(vectorLayer->extent());
	mapWidget->setLayerSet(myLayerSet);
}