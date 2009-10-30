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
#include <deque>

#define CORE_EXPORT
#define GUI_EXPORT
#include "qgis/qgsproviderregistry.h"
#include "qgis/qgsvectorlayer.h"
#include "qgis/qgsmaplayerregistry.h"
#include "qgis/qgsmapcanvas.h"

class MainWindow : public QMainWindow
{
	Q_OBJECT

	static const size_t minimumX = 640;
	static const size_t minimumY = 480;
	static const QString myPluginsDir;
	
public:
	MainWindow(QWidget* parent = NULL);
private:
	void addVectorLayer(const QString& filePath);
	
	QgsMapCanvas* mapWidget;
	QList<QgsMapCanvasLayer> myLayerSet;
};

#endif // _MAIN_WINDOW_H
