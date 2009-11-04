/*
 *  SearchDialog.cpp
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 02.11.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#include "SearchDialog.h"
#include "Layer.h"
#include "GISObject.h"
#include "GISObjectViewerDialog.h"

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
	uiSearchByNameDialog->layerList->selectAll();
}
void SearchDialog::clearSearchResult()
{
	foreach(const GISObject* objP, searchResult)
	{
		delete objP;		
	}
	searchResult.clear();
}

SearchDialog::~SearchDialog()
{
	clearSearchResult();
	delete uiSearchByNameDialog;
}
void SearchDialog::search()
{
	clearSearchResult();
	uiSearchByNameDialog->searchResult->clear();
	foreach(QListWidgetItem* item, uiSearchByNameDialog->layerList->selectedItems())
		for (int i = 0 ; i < layers->size() ; i++)
			if (layers->at(i)->name() == item->text())
				searchResult += layers->at(i)->search( uiSearchByNameDialog->searchString->text() );
	
	foreach(const GISObject* objP, searchResult)
		uiSearchByNameDialog->searchResult->addItem( objP->toString() );
}
void SearchDialog::showGISObject(QListWidgetItem* item)
{
	GISObjectViewerDialog dialog( searchResult.at(uiSearchByNameDialog->searchResult->row( item )) );
	dialog.exec();
}
const QList<GISObject*> SearchDialog::selectedObjects() // beware GISObjects will be deleted if SearchDialog deleted
{
	QList<GISObject*> list;
	foreach( QListWidgetItem* item, uiSearchByNameDialog->searchResult->selectedItems())
	{
		list.push_back( searchResult.at( uiSearchByNameDialog->searchResult->row( item ) ) );
	}
	return list;
}
