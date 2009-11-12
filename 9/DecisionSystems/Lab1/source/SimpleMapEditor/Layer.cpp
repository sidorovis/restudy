/*
 *  LayerList.cpp
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 01.11.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#include "Layer.h"
#include "GISObject.h"
#include "qgis/qgsgeometry.h"

const QString Layer::vectorProviderName("ogr");

Layer::Layer( const QFileInfo& fileName_ )
: QgsVectorLayer(fileName_.filePath(), fileName_.completeBaseName(), vectorProviderName),
  fileName( fileName_ ),
  visible( true ),
  showLabels( false ),
  feature_attribute_label_index( -1 )
{
}
Layer::~Layer()
{
}
const QList<GISObject*> Layer::search(QString text)
{
	QList<GISObject*> objects;
	for (int i = 1 ; i <= this->featureCount() ; i++)
	{
		QgsFeature f;
		this->featureAtId(i, f);
		foreach( const QVariant& u, f.attributeMap())
		{
			if (u.type() == QVariant::String && u.toString().compare(text, Qt::CaseInsensitive) == 0)
			{
				objects.push_back( GISObject::generateGISObject( this , f ) );
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
GISObject* Layer::search(const QgsPoint& click)
{
	QgsGeometry* clickGeometry = QgsGeometry::fromPoint(click);
	QList<GISObject*> objects;
	double minimal_distance = MINIMAL_DOUBLE;
	int min_feature_id = -1;
	for (int i = 1 ; i <= this->featureCount() ; i++)
	{
		QgsFeature f;
		this->featureAtId(i, f);
		QgsGeometry* featureGeometry = f.geometry();
		if ( featureGeometry->distance( *clickGeometry ) < minimal_distance )
		{
			minimal_distance = featureGeometry->distance( *clickGeometry );
			min_feature_id = i;
		}
	}
	if (min_feature_id != -1)
	{
		QgsFeature f;
		this->featureAtId(min_feature_id, f);
		delete clickGeometry;
		if (minimal_distance < POSSIBLE_MINIMAL_DISTANCE)
			return GISObject::generateGISObject( this , f );
		else
			return NULL;
	}
	delete clickGeometry;
	return NULL;
}
