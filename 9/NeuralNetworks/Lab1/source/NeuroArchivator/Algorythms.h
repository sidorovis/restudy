/*
 *  Algorythms.h
 *  NeuroArchivator
 *
 *  Created by Ivan Sidarau on 16.09.09.
 *  Copyright 2009 rilley_elf corp. All rights reserved.
 *
 */

#include <stdlib.h>
#include <math.h>

#define RANDOM_MULTIMIZATOR 100

double myrand();

double getDiff( int count, double* left, double* right);

double getLocalTeachK( double* vectorY, int length);
