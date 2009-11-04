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


class SearchDialog : public QDialog
{
	Q_OBJECT
	Ui::SearchByNameDialog* uiSearchByNameDialog;
	const QList<Layer*>* layers;
public:
	SearchDialog(const QList<Layer*>* layers_, QWidget* parent = 0);
	~SearchDialog();
private slots:
	void search();
};

#endif _SEARCH_DIALOG_H