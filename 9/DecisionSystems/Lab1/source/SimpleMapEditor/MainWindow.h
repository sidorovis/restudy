/*
 *  MainWindow.h
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 29.10.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#ifndef _MAIN_WINDOW_H
#define _MAIN_WINDOW_H

#include <QMainWindow>
#include <QFileDialog>
#include <QMessageBox>
#include <QStringListModel>
#include <QStringList>


#include "LayerItem.h"

#define CORE_EXPORT
#define GUI_EXPORT
#include "ui_MainWindow.h"
#include "qgis/qgsproviderregistry.h"
#include "qgis/qgsvectorlayer.h"
#include "qgis/qgsmaplayerregistry.h"
#include "qgis/qgsmapcanvas.h"

class MainWindow : public QMainWindow
{
	Q_OBJECT
	Ui::MainWindow* uiMainWindow;
	static const QString myPluginsDir;
	static const QString vectorProviderName;
	
public:
	MainWindow(QWidget* parent = NULL);
private:
	void addVectorLayer(const QString& filePath);
	
	QList<QgsMapCanvasLayer> myLayerSet;
	QStringList layerNames;
	QStringListModel* layerNamesModel;
	
private slots:
	void loadOgrFile();
	void showLayersProperties();
};

#endif // _MAIN_WINDOW_H
