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
@synthesize gammaValue;

- (id) init
{
	[super init];
	value = 0;
	affectOnArray = [[NSMutableArray alloc] init];
	return self;
}
- (void) dealloc
{
	[affectOnArray release];
	[super dealloc];
}
- (void) connectRandomAffectToNeuron:(Neuron*)neuron_
{
	RandomAffect* affect = [[RandomAffect alloc] initRandomTo:neuron_];
	[affectOnArray addObject:affect];
}
- (void) connectContextAffectToNeuron:(Neuron*)neuron_
{
	ContextAffect* affect = (ContextAffect*)[[ContextAffect alloc] initToNeuron:neuron_];
	[affectOnArray addObject:affect];
}
- (void) affect
{
	for (Affect <AffectorProtocol>* affect in affectOnArray)
		[affect affectWith:value];
}
- (void) teachWithAlpha:(double)alpha
{
	for (Affect<AffectorProtocol>* affect in affectOnArray)
		[affect decreaseValue: ( alpha * value ) ];
}
- (void) calculateGammaValue
{
	for (Affect<AffectorProtocol>* affect in affectOnArray)
		gammaValue += [affect getValue] * [[affect neuron] getDiff];
}

- (double) getDiff
{
	return value - gammaValue;
}

@end
