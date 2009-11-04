/*
 *  DistanceShowDialog.h
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 05.11.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#ifndef DISTANCE_SHOW_DIALOG_h
#define DISTANCE_SHOW_DIALOG_h

#include "ui_DistanceShowDialog.h"

class DistanceShowDialog : public QDialog 
{
	Q_OBJECT
	Ui::DistanceShowDialog *uiDistanceShowDialog;
public:
	DistanceShowDialog(QWidget* parent = NULL);
	~DistanceShowDialog();
	void setSize(int size);
	void setValue(int x, int y, QString value);
	void setTitles(const QStringList& list);
};

#endif // DISTANCE_SHOW_DIALOG_h
