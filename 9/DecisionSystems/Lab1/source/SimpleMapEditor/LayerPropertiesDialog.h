/*
 *  LayerPropertiesDialog.h
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 01.11.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#ifndef _LAYER_PROPERTIES_DIALOG_h
#define _LAYER_PROPERTIES_DIALOG_h 

#include <QDialog>
#include "ui_LayerSettingsDialog.h"
#include "Layer.h"

class LayerPropertiesDialog : public QDialog
{
	Q_OBJECT
	
	Ui::LayerSettingsDialog* layerSettingsDialog;
	Layer* layer;
	
public:
	LayerPropertiesDialog(Layer* layer_, QWidget* parent = 0);

private slots:
	void changeVisibility(bool visible);
};


#endif //  _LAYER_PROPERTIES_DIALOG_h
