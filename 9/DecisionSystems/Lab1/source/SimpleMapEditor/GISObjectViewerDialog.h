/*
 *  GISObjectViewerDialog.h
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 04.11.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#ifndef _GIS_OBJECT_VIEWER_DIALOG_H
#define _GIS_OBJECT_VIEWER_DIALOG_H

#include <QDialog>
#include <QMutex>
#include "ui_GisObjectViewer.h"

#include "GISObject.h"

class GISObjectViewerDialog : public QDialog 
{
	Q_OBJECT
	
	QList<GISObject*> objects;
	QList<int> object_start_from;
	Ui::GISObjectViewer* const uiGisObjectViewer;
	QMutex *mutex;
	bool changed_by_program;
public:
	GISObjectViewerDialog(GISObject* gisObject, QWidget* parent = NULL);
	GISObjectViewerDialog(const QList<GISObject*>& gisObject, QWidget* parent = NULL);
	~GISObjectViewerDialog();
private:
	void showObjects();
	void init();
	int findObjectIndex( int changed );
public slots:
	void itemChanged(QTableWidgetItem* item);
};


#endif // _GIS_OBJECT_VIEWER_DIALOG_H

