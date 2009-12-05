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
class QgsPoint;

class GISObject
{
public:
	Layer* parentLayer;
	QgsFeature* f;
	int feature_index;
	int title_index;

	static GISObject* generateGISObject(Layer* layer, QgsFeature* f, int feature_index_);
	virtual ~GISObject();
	virtual const QString toString() const;
	virtual const QString toSmallString() const;
	virtual const QStringList attributes() const;
	virtual const QHash<QString,QString> attributes_map() const;
	virtual bool setAttribute(int index, QString text);
	virtual const double length(const int a, const int rf ) const;	
	virtual const QgsPoint center() const;	
protected:
	GISObject(Layer* layer, QgsFeature* f);
private:
	GISObject(const GISObject&);
	GISObject();
};

#endif // _GIS_OBJECT_H
