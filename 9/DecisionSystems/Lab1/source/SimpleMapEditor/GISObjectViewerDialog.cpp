/*
 *  GISObjectViewerDialog.cpp
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 04.11.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#include "GISObjectViewerDialog.h"

GISObjectViewerDialog::GISObjectViewerDialog(const GISObject* const gisObject, QWidget* parent)
: QDialog( parent )
, uiGisObjectViewer( new Ui::GISObjectViewer() )
, object( gisObject )
{
	uiGisObjectViewer->setupUi( this );
	foreach( const QString& attr, gisObject->attributes())
	{
		uiGisObjectViewer->listWidget->addItem(attr);
	}
}


GISObjectViewerDialog::~GISObjectViewerDialog()
{
	delete uiGisObjectViewer;
}