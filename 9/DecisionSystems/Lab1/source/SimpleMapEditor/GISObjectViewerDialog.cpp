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
	init();
}
GISObjectViewerDialog::GISObjectViewerDialog(const QList<GISObject*>& gisObjects, QWidget* parent)
: QDialog( parent )
, uiGisObjectViewer( new Ui::GISObjectViewer() )
{
	objects = gisObjects;
	init();
}
void GISObjectViewerDialog::init()
{
	uiGisObjectViewer->setupUi( this );
	uiGisObjectViewer->tableWidget->setColumnCount( 2 );
	uiGisObjectViewer->tableWidget->setRowCount( 0 );
	mutex = new QMutex();
	changed_by_program = false;
	showObjects();	
}
GISObjectViewerDialog::~GISObjectViewerDialog()
{
	delete uiGisObjectViewer;
}
void GISObjectViewerDialog::showObjects()
{
	mutex->lock();
	changed_by_program = true;
	mutex->unlock();
	foreach(GISObject* object, objects)
	{
		QHash<QString, QString> attr_hash =  object->attributes_map();

		int before_attr_count = uiGisObjectViewer->tableWidget->rowCount();
		int added_attr_count = attr_hash.size() ;
		object_start_from << before_attr_count;
		uiGisObjectViewer->tableWidget->setRowCount( before_attr_count + added_attr_count + 1);
		uiGisObjectViewer->tableWidget->setItem( before_attr_count, 0 , new QTableWidgetItem("-="+object->toSmallString()+"=-"));
		for (int i = 0 ; i < added_attr_count ; i++)
		{
			uiGisObjectViewer->tableWidget->setItem( before_attr_count + i + 1 , 0,
								new QTableWidgetItem(attr_hash.keys()[i]) );
			uiGisObjectViewer->tableWidget->setItem( before_attr_count + i + 1, 1,
								new QTableWidgetItem(attr_hash.value(attr_hash.keys()[i])) );			
		}
	}
	mutex->lock();
	changed_by_program = false;
	mutex->unlock();
}
void GISObjectViewerDialog::itemChanged(QTableWidgetItem* item)
{
	mutex->lock();
	if (!changed_by_program && item->column() == 1)
	{
		int item_index = findObjectIndex( item->row() );
		GISObject* object = objects[ item_index ];
		object->setAttribute( item->row() - item_index, item->text());
	}
	mutex->unlock();
}
int GISObjectViewerDialog::findObjectIndex( int changed )
{
	int i = 0 ;
	for ( ; i < object_start_from.size() ; i++)
		if ( object_start_from[i] > changed )
			break;
	return --i;
}
