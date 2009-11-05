/*
 *  WGS84Hack.h
 *  SimpleMapEditor
 *
 *  Created by Ivan Sidarau on 05.11.09.
 *  Copyright 2009 Rilley_Elf Corp. All rights reserved.
 *
 */

#ifndef _WGS84_HACK_H
#define _WGS84_HACK_H

#define CORE_EXPORT
#define GUI_EXPORT
#include "qgis/qgspoint.h"
#include "math.h"

#define 	DEG2RAD(x)   ((x)*M_PI/180)

class MyDistanceArea
{ 
public:
	static double computeDistanceBearing( const QgsPoint& p1, const QgsPoint& p2);
};



#endif // _WGS84_HACK_H