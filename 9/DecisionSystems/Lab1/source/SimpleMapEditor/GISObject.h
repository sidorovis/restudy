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

class GISObject
{
	
public:
	GISObject(const QgsFeature& f);
	virtual ~GISObject();
	virtual const QString toString() const;
};

#endif // _GIS_OBJECT_H
