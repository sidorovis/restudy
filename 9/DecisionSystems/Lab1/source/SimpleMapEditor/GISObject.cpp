/*
 *  GISObject.cpp
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 03.11.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#include "GISObject.h"
#include "Layer.h"
#include "qgis/qgsgeometry.h"
#include "qgis/qgis.h"
#include "qgis/qgspoint.h"
#include "qgis/qgsvectordataprovider.h"

#include "WGS84Hack.h"

GISObject* GISObject::generateGISObject(Layer* layer, QgsFeature& f)
{
	GISObject* object;
	object = new GISObject( layer, f );
	if (layer->name() == "city")
		object->title_index = 5;
	else 
	if (layer->name() == "roads")
		object->title_index = 5;
	else
	if (layer->name() == "regions")
		object->title_index = 3;
	else
		object->title_index = 0;
		
	return object;
}

GISObject::GISObject(Layer* layer, QgsFeature& feature)
: parentLayer( layer )
, f ( feature )
{}
GISObject::~GISObject(){}
const QString GISObject::toString() const
{
	return parentLayer->name()+" "+parentLayer->dataProvider()->fields()[title_index].name()+": "+f.attributeMap()[title_index].toString();
}
const QString GISObject::toSmallString() const
{
	return f.attributeMap()[title_index].toString();
}

const QStringList GISObject::attributes() const
{
	QStringList list;
	for (int i = 0 ; i < parentLayer->dataProvider()->fields().size() ; i++)
	{
		list.push_back( parentLayer->dataProvider()->fields()[i].name()+": "+f.attributeMap()[i].toString() );
	}
	const QgsPoint objCenter = center();
	list.push_back( "Long: "+QString("%1").arg(objCenter.x()) );
	list.push_back( "Lat: "+QString("%1").arg(objCenter.y()) );
	return list;
}
const double GISObject::length() const
{
	if ((static_cast<QgsFeature>(f)).geometry()->type() == QGis::Line)
	{
		double result = 0;
		QgsPolyline polyLine = (static_cast<QgsFeature>(f)).geometry()->asPolyline();
		for (int i = 0 ; i < polyLine.size() - 1 ; i++)
			result += MyDistanceArea::computeDistanceBearing( polyLine.at(i), polyLine.at(i+1) );
		return result;
	}
	else
		return 0;
}
const QgsPoint GISObject::center() const
{
	return (static_cast<QgsFeature>(f)).geometry()->centroid()->asPoint();
}
