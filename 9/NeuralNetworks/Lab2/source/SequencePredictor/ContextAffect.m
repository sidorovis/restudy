//
//  ContextAffect.m
//  SequencePredictor
//
//  Created by Ivan Sidarau on 24.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import "ContextAffect.h"


@implementation ContextAffect
-(ContextAffect*) initToNeuron:(Neuron*)neuron_
{
	[super initWithValue:1 toNeuron:neuron_];
	return self;
}

@end
