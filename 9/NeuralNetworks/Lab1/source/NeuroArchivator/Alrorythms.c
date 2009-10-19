/*
 *  Alrorythms.c
 *  NeuroArchivator
 *
 *  Created by Ivan Sidarau on 16.09.09.
 *  Copyright 2009 rilley_elf corp. All rights reserved.
 *
 */

#include "Algorythms.h"

double myrand()
{
//	return ((double)(rand() % RANDOM_MULTIMIZATOR)) / (1.0*RANDOM_MULTIMIZATOR);
	return ((double)(rand() % RANDOM_MULTIMIZATOR)) / (1.0*RANDOM_MULTIMIZATOR) - (RANDOM_MULTIMIZATOR*0.5)/RANDOM_MULTIMIZATOR;
}

double getDiff( int count, double* left, double* right )
{
	double diff = 0;
	for (int i = 0 ; i < count ; i++)
		diff += fabs(left[i] - right[i]);
	return diff;
}
double getLocalTeachK( double* vectorY, int length)
{
	double summ = 0;
	for (int i = 0 ; i < length ; i++)
		summ += vectorY[i];
	return 1.0/(1.0+summ);
}
