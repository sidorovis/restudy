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
#import "ContextRandomAffect.h"
#import <math.h>

double my_func( double value )
{
	return value;
//	atanh(<#double #>)
//	return tanh( value );
}
double my_func_derivative( double value )
{
	return 1.0;
//	return 1.0 / ( cosh( value )*cosh( value ) );
}

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
- (void) connectContextRandomAffectToNeuron:(Neuron*)neuron_
{
	ContextRandomAffect* affect = [[ContextRandomAffect alloc] initContextRandomTo:neuron_];
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
		[affect teachAffector:alpha xValue:value];
}
- (void) calculateGammaValue
{
	for (Affect<AffectorProtocol>* affect in affectOnArray)
		gammaValue += [affect getValue] * [affect neuron].gammaValue * my_func_derivative( [affect neuron].value );
}
- (double) getDiff
{
	return value - gammaValue;
}
- (void) debug
{
	NSLog(@" - - %@ Neuron:: value: %f, gammaValue: %f", self,value, gammaValue);
	for (Affect<AffectorProtocol>* affect in affectOnArray) {
		[affect debug];
	}
}

@end
