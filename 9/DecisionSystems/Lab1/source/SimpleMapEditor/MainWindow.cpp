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
const QString MainWindow::vectorProviderName("ogr");

MainWindow::MainWindow(QWidget* parent) : 
     QMainWindow(parent),
     uiMainWindow(new Ui::MainWindow)
{
	uiMainWindow->setupUi(this);
	QgsProviderRegistry::instance(MainWindow::myPluginsDir);
	uiMainWindow->mapWidget->setCanvasColor( QColor(255,255,255) );	
	layerNamesModel = new QStringListModel();
	uiMainWindow->layerList->setModel(layerNamesModel);
	show();	
}

void MainWindow::addVectorLayer(const QString& filePath)
{
	QFileInfo layerFileInfo(filePath);
	QgsVectorLayer* vectorLayer = new QgsVectorLayer(layerFileInfo.filePath(), layerFileInfo.completeBaseName(), vectorProviderName );
	if (!vectorLayer->isValid())
	{
		QMessageBox messageBox;
		messageBox.setText("This file content wrong vector layer");
		messageBox.exec();
	}
	else
	{
		layerNames.push_back(layerFileInfo.baseName());
		layerNamesModel->setStringList(layerNames);
		QgsMapLayerRegistry::instance()->addMapLayer(vectorLayer, TRUE);	
		myLayerSet.push_back(vectorLayer);
		uiMainWindow->mapWidget->clear();
		uiMainWindow->mapWidget->setExtent(vectorLayer->extent());
		uiMainWindow->mapWidget->setLayerSet(myLayerSet);		
	}
}
void MainWindow::loadOgrFile()
{
	QFileDialog fileDialog(this, "Choose OGR vector file", "~/", tr("Vector Layer files (*.mif *.tab)"));
	fileDialog.setAcceptMode(QFileDialog::AcceptOpen);
	fileDialog.setFileMode(QFileDialog::ExistingFile);
	if (fileDialog.exec())
		addVectorLayer(fileDialog.selectedFiles().at(0));
}
void MainWindow::showLayersProperties()
{
	
	qDebug() <<"PROP";
}