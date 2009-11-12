/*
 *  GISObjectViewerDialog.cpp
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 04.11.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#include "GISObjectViewerDialog.h"
#include "Layer.h"
#include <QList>

GISObjectViewerDialog::GISObjectViewerDialog(GISObject* gisObject, QWidget* parent)
: QDialog( parent )
, uiGisObjectViewer( new Ui::GISObjectViewer() )
{
	objects << gisObject;
	uiGisObjectViewer->setupUi( this );
	showObjects();
}
GISObjectViewerDialog::GISObjectViewerDialog(const QList<GISObject*>& gisObjects, QWidget* parent)
: QDialog( parent )
, uiGisObjectViewer( new Ui::GISObjectViewer() )
{
	objects = gisObjects;
	uiGisObjectViewer->setupUi( this );
	showObjects();	
}

GISObjectViewerDialog::~GISObjectViewerDialog()
{
	delete uiGisObjectViewer;
}
void GISObjectViewerDialog::showObjects()
{
	foreach(GISObject* object, objects)
	{
		uiGisObjectViewer->listWidget->addItem( object->parentLayer->name() );
		foreach( const QString& attr, object->attributes())
		{
			uiGisObjectViewer->listWidget->addItem(attr);
		}		
	}
}
