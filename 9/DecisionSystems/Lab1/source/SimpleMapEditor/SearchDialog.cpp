/*
 *  SearchDialog.cpp
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 02.11.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#include "SearchDialog.h"

SearchDialog::SearchDialog(const QList<Layer*>* layers_, QWidget* parent) 
    : QDialog( parent )
    , uiSearchByNameDialog( new Ui::SearchByNameDialog() )
{
	layers = layers_;
	uiSearchByNameDialog->setupUi( this );
	foreach(Layer* layer, *layers)
	{
		uiSearchByNameDialog->layerList->addItem(layer->name());
	}
}
SearchDialog::~SearchDialog()
{
	delete uiSearchByNameDialog;
}
void SearchDialog::search()
{
	foreach(QListWidgetItem* item, uiSearchByNameDialog->layerList->selectedItems())
		for (int i = 0 ; i < layers->size() ; i++)
			if (layers->at(i)->name() == item->text())
				foreach(const GISObject obj, layers->at(i)->search( uiSearchByNameDialog->searchString->text() ))
				{
					uiSearchByNameDialog->searchResult->addItem( obj.toString() );
//					foreach( const QVariant& u, featurePtr->attributeMap())
//					{
//						if (u.type() == QVariant::String && u.toString() == item->text())
//						{
//							uiSearchByNameDialog->searchResult->addItem( u.toString() );
//							break;
//						}
//					}
				}
}
