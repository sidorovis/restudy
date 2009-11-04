/*
 *  GISObject.h
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 03.11.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#ifndef _GIS_OBJECT_H
#define _GIS_OBJECT_H

#include <QDebug>

#define CORE_EXPORT
#define GUI_EXPORT

#include "qgis/qgsfeature.h"

class Layer;

class GISObject
{
public:
	Layer* parentLayer;
	QgsFeature f;

	static GISObject* generateGISObject(Layer* layer, QgsFeature& f);
	virtual ~GISObject();
	virtual const QString toString() const;
	virtual const QString toSmallString() const;
	virtual const QStringList attributes();
protected:
	GISObject(Layer* layer, QgsFeature& f);
private:
	GISObject(const GISObject&);
	GISObject();
};

class CityObject : public GISObject
{
	QString type;
	QString title;
	QString region;
	QString subregion;
	QString description;
	double citizen_count;
public:
	CityObject(Layer* layer, QgsFeature& f);
	virtual const QString toString() const;
	virtual const QString toSmallString() const;
	virtual const QStringList attributes();	
//	virtual ~CityObject();	
};

class SubRegionObject : public GISObject
{
	QString region;
	QString title;
	QString neighbor;
public:
	SubRegionObject(Layer* layer, QgsFeature& f);
	virtual const QString toString() const;
	virtual const QString toSmallString() const;
	virtual const QStringList attributes();	
//	virtual ~SubRegionObject();		
};
#endif // _GIS_OBJECT_H
