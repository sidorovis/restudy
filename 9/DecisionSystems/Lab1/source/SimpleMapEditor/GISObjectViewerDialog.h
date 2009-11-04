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
#include "ui_GisObjectViewer.h"

#include "GISObject.h"

class GISObjectViewerDialog : public QDialog 
{
	const GISObject* const object;
	Ui::GISObjectViewer* const uiGisObjectViewer;
public:
	GISObjectViewerDialog(const GISObject* const gisObject, QWidget* parent = NULL);
	~GISObjectViewerDialog();
};


#endif // _GIS_OBJECT_VIEWER_DIALOG_H

