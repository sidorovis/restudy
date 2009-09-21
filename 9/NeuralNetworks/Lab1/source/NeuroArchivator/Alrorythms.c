/*
 *  Alrorythms.c
 *  NeuroArchivator
 *
 *  Created by Ivan Sidarau on 16.09.09.
 *  Copyright 2009 rilley_elf corp. All rights reserved.
 *
 */

#include "Algorythms.h"

float myrand()
{
	return ((float)((rand()%2?1.0:1.0) * (rand() % RANDOM_MULTIMIZATOR))) / 100.0;
//	return ((float)((rand()%2?0.499:-0.499) * (rand() % RANDOM_MULTIMIZATOR))) / 100.0;
}

float getDiff( int count, float* left, float* right )
{
	float diff = 0;
	for (int i = 0 ; i < count ; i++)
		diff += fabs(left[i] - right[i]);
	return diff;
}
