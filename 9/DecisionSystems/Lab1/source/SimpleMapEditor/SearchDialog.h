/*
 *  SearchDialog.h
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 02.11.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#ifndef _SEARCH_DIALOG_H
#define _SEARCH_DIALOG_H

#include <QDebug>
#include <QDialog>
#include "ui_SearchByNameDialog.h"

#define CORE_EXPORT
#define GUI_EXPORT

#include "qgis/qgsfeature.h"

class Layer;
class GISObject;

class SearchDialog : public QDialog
{
	Q_OBJECT
	Ui::SearchByNameDialog* uiSearchByNameDialog;
	const QList<Layer*>* layers;
	QList<GISObject*> searchResult;
	Layer* editLayer;
	
public:
	SearchDialog(const QList<Layer*>* layers_, Layer* editLayer_ ,QWidget* parent = 0);
	~SearchDialog();
	const QList<GISObject*> selectedObjects();
private:
	void clearSearchResult();
private slots:
	void search();
	void showGISObject(QListWidgetItem* item);
};

#endif _SEARCH_DIALOG_H