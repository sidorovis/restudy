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

#include <QDebug>
#include <QFileInfo>
#include <QStringListModel>
#include "GISObject.h"

#define CORE_EXPORT
#define GUI_EXPORT

#include "qgis/qgsvectorlayer.h"
#include "qgis/qgsmaplayerregistry.h"

class Layer : public QgsVectorLayer
{
	Q_OBJECT
	
	static const QString vectorProviderName;
		
public:
	QFileInfo fileName;
	bool visible;
	
	Layer(const QFileInfo& fileName_);	
	virtual ~Layer();
	
	const QList<GISObject> search(QString text);
};

const QStringList getLayerNameList(const QList<Layer*>& list );

#endif _LAYER_H
