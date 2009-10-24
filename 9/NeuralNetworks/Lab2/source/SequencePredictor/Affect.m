//
//  Reactor.m
//  SequencePredictor
//
//  Created by Ivan Sidarau on 23.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import "Affect.h"


@implementation Affect

@synthesize value;
@synthesize neuron;

-(Affect*) initToNeuron:(Neuron*)neuron_;
{
	[super init];
	neuron = neuron_;
	return self;
}
-(void) dealloc
{
	[neuron retain];
	[super dealloc];
}

@end
