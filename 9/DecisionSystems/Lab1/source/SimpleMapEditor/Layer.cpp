/*
 *  LayerList.cpp
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 01.11.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#include "Layer.h"

const QString Layer::vectorProviderName("ogr");

Layer::Layer( const QFileInfo& fileName_ )
: QgsVectorLayer(fileName_.filePath(), fileName_.completeBaseName(), vectorProviderName),
  fileName( fileName_ ),
  visible( true )
{
}
Layer::~Layer()
{
}
const QList<GISObject> Layer::search(QString text)
{
	QList<GISObject> objects;
	for (int i = 1 ; i <= this->featureCount() ; i++)
	{
		QgsFeature f;
		this->featureAtId(i, f);
		foreach( const QVariant& u, f.attributeMap())
		{
			if (u.type() == QVariant::String && u.toString().compare(text, Qt::CaseInsensitive) == 0)
			{
				objects.push_back(GISObject(f));
				break;
			}
		}
	}
	return objects;
}
const QStringList getLayerNameList(const QList<Layer*>& list )
{
	QStringList stringList;
	foreach( Layer* layer, list )
		stringList.push_back(layer->fileName.baseName());
	return stringList;
}
