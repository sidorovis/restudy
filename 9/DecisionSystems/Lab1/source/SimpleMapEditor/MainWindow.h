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


class MainWindow : public QMainWindow
{
	static const size_t minimumX = 640;
	static const size_t minimumY = 480;
	Q_OBJECT
public:
	MainWindow(QWidget* parent = NULL);
	
};

#endif // _MAIN_WINDOW_H
