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
	value = (rand()%1000000) / 1000000.0;
	[super initToNeuron:neuron_];
	return self;
}
-(void) affectWith:(double) value_;
{
	neuron.value += value_*value;
}

@end
