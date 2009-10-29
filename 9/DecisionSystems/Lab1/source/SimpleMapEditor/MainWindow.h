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
	static const size_t minimumX = 640;
	static const size_t minimumY = 480;
	Q_OBJECT
public:
	MainWindow(QWidget* parent = NULL);
private:
	void addVectorLayer();	
	
	QgsMapCanvas* mapWidget;
};

#endif // _MAIN_WINDOW_H
