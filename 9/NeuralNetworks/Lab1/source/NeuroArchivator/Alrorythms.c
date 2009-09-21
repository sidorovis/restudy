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
	return ((float)(rand() % RANDOM_MULTIMIZATOR)) / (1.0*RANDOM_MULTIMIZATOR);
}

float getDiff( int count, float* left, float* right )
{
	float diff = 0;
	for (int i = 0 ; i < count ; i++)
		diff += fabs(left[i] - right[i]);
	return diff;
}
