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

float myrand();

float getDiff( int count, float* left, float* right);

float getLocalTeachK( float* vectorY, int length);
