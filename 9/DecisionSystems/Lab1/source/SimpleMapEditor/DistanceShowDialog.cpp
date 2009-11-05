/*
 *  DistanceShowDialog.cpp
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 05.11.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#include "DistanceShowDialog.h"
#include <QTableWidget>

DistanceShowDialog::DistanceShowDialog(QWidget* parent)
: QDialog( parent )
, uiDistanceShowDialog( new Ui::DistanceShowDialog )
{
	uiDistanceShowDialog->setupUi( this );
	uiDistanceShowDialog->table->setSortingEnabled( false );
}
DistanceShowDialog::~DistanceShowDialog()
{
	delete uiDistanceShowDialog;
}
void DistanceShowDialog::setSize(int size)
{
	uiDistanceShowDialog->table->setRowCount( size );
	uiDistanceShowDialog->table->setColumnCount( size );
}
void DistanceShowDialog::setValue(int x, int y, QString value)
{
	uiDistanceShowDialog->table->setItem( x, y, new QTableWidgetItem(value) );
	uiDistanceShowDialog->table->setItem( y, x, new QTableWidgetItem(value) );
}
void DistanceShowDialog::setTitles(const QStringList& list)
{
	uiDistanceShowDialog->table->setHorizontalHeaderLabels( list );
	uiDistanceShowDialog->table->setVerticalHeaderLabels( list );
}
