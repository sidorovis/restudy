//
//  RandomAffect.m
//  SequencePredictor
//
//  Created by Ivan Sidarau on 24.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import "RandomAffect.h"


@implementation RandomAffect
-(RandomAffect*) initRandomTo:(Neuron*)neuron_
{
	double random_value = (rand()%1000000) / 1000000.0;
	[super initWithValue:random_value toNeuron:neuron_];
	return self;
}

@end
