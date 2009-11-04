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

GISObject* GISObject::generateGISObject(Layer* layer, const QgsFeature& f)
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

GISObject::GISObject(Layer* layer, const QgsFeature& feature)
: parentLayer( layer )
, f ( feature )
{}
GISObject::~GISObject(){}
const QString GISObject::toString() const
{
	return parentLayer->name()+" "+QString(" Unknown Object ");
}
const QStringList GISObject::attributes() const
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
CityObject::CityObject(Layer* layer, const QgsFeature& f) 
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
const QStringList CityObject::attributes() const
{
	QStringList list;
	list.push_back( "Title: "+title );
	list.push_back( "Type: "+type );
	list.push_back( "Region: "+region );
	list.push_back( "SubRegion: "+subregion );
	list.push_back( "Citizen count: "+QString("%1").arg(citizen_count) );
	list.push_back( "Description: "+description );
	return list;
}

// SubRegionObject
SubRegionObject::SubRegionObject(Layer* layer, const QgsFeature& f) 
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
const QStringList SubRegionObject::attributes() const
{
	QStringList list;
	list.push_back( region+" region" );
	list.push_back( title+" subregion" );
	if (neighbor != "")
		list.push_back( neighbor+" neighbors" );
	return list;
}
