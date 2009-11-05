/*
 *  LayerPropertiesDialog.cpp
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 01.11.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#include "LayerPropertiesDialog.h"
#include "qgis/qgsvectordataprovider.h"

LayerPropertiesDialog::LayerPropertiesDialog(Layer* layer_, QWidget* parent) : 
  QDialog(parent),
  layerSettingsDialog( new Ui::LayerSettingsDialog ),
  layer( layer_ )
{
	layerSettingsDialog->setupUi( this );
	layerSettingsDialog->label->setText( layer->name() );
	if (layer->visible)
		layerSettingsDialog->checkBox->setCheckState( Qt::Checked );
	else
		layerSettingsDialog->checkBox->setCheckState( Qt::Unchecked );
	if (layer->showLabels)
		layerSettingsDialog->checkBox_2->setCheckState( Qt::Checked );
	else
		layerSettingsDialog->checkBox_2->setCheckState( Qt::Unchecked );
}
LayerPropertiesDialog::~LayerPropertiesDialog()
{
	delete layerSettingsDialog;
}
void LayerPropertiesDialog::changeVisibility(bool visible)
{
	layer->visible = visible;
}
void LayerPropertiesDialog::showFieldNames(bool state)
{
	if (state == false)
	{
		layer->showLabels = false;
		layer->feature_attribute_label_index = -1;
		layerSettingsDialog->comboBox->clear();
		layerSettingsDialog->comboBox->setEnabled( false );
		return;
	}
	layer->showLabels = true;
	int current_index;
	if (layer->feature_attribute_label_index == -1)
		current_index = 0;
	else
		current_index = layer->feature_attribute_label_index;
	layerSettingsDialog->comboBox->setEnabled( true );
	layerSettingsDialog->comboBox->clear();
	foreach(const QgsField& field, layer->dataProvider()->fields())
	{
		layerSettingsDialog->comboBox->addItem(field.name());
	}
	layerSettingsDialog->comboBox->setCurrentIndex(current_index);
}
void LayerPropertiesDialog::layerLabelFieldChanged(int index)
{
	layer->feature_attribute_label_index = index;
}
