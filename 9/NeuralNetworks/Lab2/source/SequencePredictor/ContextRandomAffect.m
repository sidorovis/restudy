//
//  ContextRandomAffect.m
//  SequencePredictor
//
//  Created by Ivan Sidarau on 17.11.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import "ContextRandomAffect.h"
#import "Neuron.h"

@implementation ContextRandomAffect

-(ContextRandomAffect*) initContextRandomTo:(Neuron*)neuron_
{
	[super initToNeuron:neuron_];
	return self;
}
-(void) teachAffector:(double)alpha xValue:(double)value_
{
	value -= alpha * my_func( value_ ) * [neuron gammaValue] * my_func_derivative(value_);
}

@end
