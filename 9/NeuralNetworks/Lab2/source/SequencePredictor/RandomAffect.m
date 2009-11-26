//
//  RandomAffect.m
//  SequencePredictor
//
//  Created by Ivan Sidarau on 24.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import "RandomAffect.h"
#define basis 1000000


@implementation RandomAffect
-(RandomAffect*) initRandomTo:(Neuron*)neuron_
{
	value = ((rand()%basis)-basis / 2.0) / (double)basis;
	[super initToNeuron:neuron_];
	return self;
}
-(void) affectWith:(double) value_;
{
	neuron.value += value_*value;
}
-(void) teachAffector:(double)alpha xValue:(double)value_
{
//	value -= alpha * my_func( value_ ) * [neuron gammaValue]; // TODO: домножить на проиводную функции активации
	value -= alpha *  value_  * [neuron gammaValue] * my_func_derivative( value_ );
}

-(double) getValue
{
	return value;
}
-(void) normilizeAffect:(double)summ
{
	value /= summ;
}
-(void) debug
{
	NSLog(@" - - - %@ RandomAffect: %f %@", self,value,neuron);
}

@end
