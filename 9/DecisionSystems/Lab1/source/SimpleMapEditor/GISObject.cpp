/*
 *  GISObject.cpp
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 03.11.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#include "GISObject.h"

GISObject::GISObject(const QgsFeature& f)
{
//	QgsGeometry geom = f.geometry();
//	polygons = geom.asMultiPolygon();
/*	foreach( const QVariant& var, f.attributeMap())
	{
		
		qDebug() << var;
	}*/
}
GISObject::~GISObject()
{
	
}
const QString GISObject::toString() const
{
	return QString("Name");
}