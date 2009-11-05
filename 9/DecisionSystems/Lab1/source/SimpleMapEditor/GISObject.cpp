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

GISObject* GISObject::generateGISObject(Layer* layer, QgsFeature& f)
{
	GISObject* object;
	if (layer->name() == "city")
		object = new CityObject( layer, f );
	else
	if (layer->name() == "regions")
		object = new SubRegionObject( layer, f );
	else
		object = new GISObject( layer, f );
		
	return object;
}

GISObject::GISObject(Layer* layer, QgsFeature& feature)
: parentLayer( layer )
, f ( feature )
{}
GISObject::~GISObject(){}
const QString GISObject::toString() const
{
	return parentLayer->name()+" "+QString(" unspecified");
}
const QString GISObject::toSmallString() const
{
	return QString("Unknown");
}

const QStringList GISObject::attributes()
{
	QStringList list;
	foreach( const QVariant& var, f.attributeMap())
	{
		if (var.type() == QVariant::String)
			list.push_back( var.toString() );
		if (var.type() == QVariant::Double)
			list.push_back( QString("%1").arg( var.toDouble() ) );
	}
	return list;
}

// CityInfo
CityObject::CityObject(Layer* layer, QgsFeature& f) 
 : GISObject( layer, f)
 , type ( f.attributeMap()[2].toString() )
 , region ( f.attributeMap()[3].toString() )
 , subregion ( f.attributeMap()[4].toString() )
 , title ( f.attributeMap()[5].toString() )
 , citizen_count ( f.attributeMap()[6].toDouble() )
 , description ( f.attributeMap()[10].toString() )
{}
const QString CityObject::toString() const
{
	return type+" "+title;
}
const QString CityObject::toSmallString() const
{
	return title;
}

const QStringList CityObject::attributes()
{
	QStringList list;
	list.push_back( "Title: "+title );
	list.push_back( "Type: "+type );
	list.push_back( "Region: "+region );
	list.push_back( "SubRegion: "+subregion );
	list.push_back( "Citizen count: "+QString("%1").arg(citizen_count) );
	list.push_back( "Description: "+description );
	QgsPoint center = f.geometry()->centroid()->asPoint();
	list.push_back( "X: "+QString("%1").arg(center.x()) );
	list.push_back( "Y: "+QString("%1").arg(center.y()) );
	
	return list;
}

// SubRegionObject
SubRegionObject::SubRegionObject(Layer* layer, QgsFeature& f) 
: GISObject( layer, f)
, region(f.attributeMap()[2].toString())
, title(f.attributeMap()[3].toString())
, neighbor(f.attributeMap()[4].toString() )
{
}
const QString SubRegionObject::toString() const
{
	return title+" region";
}
const QString SubRegionObject::toSmallString() const
{
	return title;
}
const QStringList SubRegionObject::attributes()
{
	QStringList list;
	list.push_back( region+" region" );
	list.push_back( title+" subregion" );
	if (neighbor != "")
		list.push_back( neighbor+" neighbors" );
	QgsPoint center = f.geometry()->centroid()->asPoint();
	list.push_back( "X: "+QString("%1").arg(center.x()) );
	list.push_back( "Y: "+QString("%1").arg(center.y()) );
	return list;
}
