/*
 *  LayerPropertiesDialog.cpp
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 01.11.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#include "LayerPropertiesDialog.h"

LayerPropertiesDialog::LayerPropertiesDialog(Layer* layer_, QWidget* parent) : 
  QDialog(parent),
  layerSettingsDialog( new Ui::LayerSettingsDialog ),
  layer( layer_ )
{
	layerSettingsDialog->setupUi( this );
	layerSettingsDialog->label->setText( layer->fileName.baseName() );
	if (layer->visible)
		layerSettingsDialog->checkBox->setCheckState( Qt::Checked );
	else
		layerSettingsDialog->checkBox->setCheckState( Qt::Unchecked );
}
void LayerPropertiesDialog::changeVisibility(bool visible)
{
	
	layer->visible = visible;
}
