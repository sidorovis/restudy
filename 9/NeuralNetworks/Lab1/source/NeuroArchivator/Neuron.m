//
//  Neuron.m
//  NeuroArchivator
//
//  Created by Ivan Sidarau on 16.09.09.
//  Copyright 2009 rilley_elf corp. All rights reserved.
//

#import "Neuron.h"


@implementation Neuron
-(Neuron*) initWithWLength:(int)length_;
{
	[super init];
	length = length_;
	vectorW = malloc( sizeof(double) * length );
	for (int i = 0 ; i < length ; i++)
		vectorW[i] = myrand();
	[self normilize];
	return self;
}
-(void) normilize
{
	double summ = [self getWSumm];
	for (int i = 0 ; i < length ; i++)
	{
		vectorW[i] /= summ;
		assert( !isnan( vectorW[i] ) );
		assert( !isinf( vectorW[i] ) );
	}
	double summ2 = [self getWSumm];
	assert (0.00001 > fabs(summ2 - 1));
}

@synthesize length;
@synthesize vectorW;

- (void) dealloc;
{
	free( vectorW );
	[super dealloc];
}
-(double*) getVectorW
{
	return vectorW;
}
-(double) getWByIndex:(int)index_
{
	return vectorW[ index_ ];
}
-(double) getReactionOnIndex:(int)index_ value:(double)value
{
	assert( !isnan( vectorW[index_] ));
	assert( !isinf( vectorW[index_] ));
	return value*vectorW[index_];
}
-(double) getWSumm
{
	double summ = 0;
	for (int i = 0 ; i < length ; i++)
		summ += fabs(vectorW[i]);
	assert(summ != 0);
	return summ;
}
@end
