//
//  Neuron.m
//  SequencePredictor
//
//  Created by Ivan Sidarau on 23.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import "Neuron.h"
#import "RandomAffect.h"
#import "ContextAffect.h"
#import <math.h>


@implementation Neuron

@synthesize value;
//@synthesize nextValue;

- (id) init
{
	[super init];
	value = 0;
	affectOn = [[NSMutableArray alloc] init];
	return self;
}
- (void) dealloc
{
	[affectOn release];
	[super dealloc];
}
- (void) connectRandomAffectToLay:(Neuron*)neuron_
{
	RandomAffect* affect = [[RandomAffect alloc] initRandomTo:neuron_];
	[affectOn addObject:affect];
}
- (void) connectContextAffectToLay:(Neuron*)neuron_
{
	ContextAffect* affect = [[ContextAffect alloc] initToNeuron:neuron_];
	[affectOn addObject:affect];
}

- (void) affect
{
	for (Affect* affected in affectOn) {
		[affected neuron].value += affected.value*value;
	}
}

@end
