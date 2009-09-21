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
	vectorW = malloc( sizeof(float) * length );
	float summ = 0;
	for (int i = 0 ; i < length ; i++)
		summ += fabs(vectorW[i] = myrand());
	for (int i = 0 ; i < length ; i++)
		vectorW[i] /= summ;
	return self;
}

@synthesize length;
@synthesize vectorW;


- (void) dealloc;
{
	free( vectorW );
	[super dealloc];
}
-(float*) getVectorW
{
	return vectorW;
}
-(float) getWByIndex:(int)index_
{
	return vectorW[ index_ ];
}
-(float) getReactionOnIndex:(int)index_ value:(float)value
{
	return value*vectorW[index_];
}

@end
