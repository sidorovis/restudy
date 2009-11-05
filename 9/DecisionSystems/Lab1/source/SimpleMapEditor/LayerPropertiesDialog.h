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

#define CORE_EXPORT
#define GUI_EXPORT

#include <QDialog>
#include "ui_LayerSettingsDialog.h"
#include "Layer.h"

class LayerPropertiesDialog : public QDialog
{
	Q_OBJECT
	
	Ui::LayerSettingsDialog* const layerSettingsDialog;
	Layer* layer;
	
public:
	LayerPropertiesDialog(Layer* layer_, QWidget* parent = 0);
	virtual ~LayerPropertiesDialog();

private slots:
	void changeVisibility(bool visible);
	void showFieldNames(bool state);
	void layerLabelFieldChanged(int index);
};

#endif //  _LAYER_PROPERTIES_DIALOG_h
