/*
 *  LayerList.h
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 01.11.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#ifndef _LAYER_H
#define _LAYER_H

#define MINIMAL_DOUBLE 99999999999
#define POSSIBLE_MINIMAL_DISTANCE 0.02

#include <QDebug>
#include <QFileInfo>
#include <QStringListModel>
#include <QString>

#define CORE_EXPORT
#define GUI_EXPORT

#include "qgis/qgsvectorlayer.h"
#include "qgis/qgsmaplayerregistry.h"

class GISObject;

class Layer : public QgsVectorLayer
{
	Q_OBJECT
	
	static const QString vectorProviderName;
		
public:
	QFileInfo fileName;
	bool visible;
	bool showLabels;
	int feature_attribute_label_index;
	
	Layer(const QFileInfo& fileName_);	
	virtual ~Layer();
	
	const QList<GISObject*> search(QString text);
	GISObject* search(const QgsPoint& click);
};

const QStringList getLayerNameList(const QList<Layer*>& list );

#endif _LAYER_H
