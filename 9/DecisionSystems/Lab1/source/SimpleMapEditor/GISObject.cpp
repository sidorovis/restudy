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

GISObject* GISObject::generateGISObject(const Layer& layer, const QgsFeature& f)
{
	GISObject* object;
	if (layer.name() == "city")
		object = new CityObject( layer, f );
	else
		object = new GISObject( layer, f );
		
	return object;
}

GISObject::GISObject(const Layer& layer, const QgsFeature&) : layer_name(layer.name()){}
GISObject::~GISObject(){}
const QString GISObject::toString() const
{
	return layer_name+" "+QString(" -- ");
}
// CityInfo
CityObject::CityObject(const Layer& layer, const QgsFeature& f) 
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
CityObject::~CityObject()
{
	
}