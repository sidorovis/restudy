//
//  ContextAffect.m
//  SequencePredictor
//
//  Created by Ivan Sidarau on 24.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import "ContextAffect.h"


@implementation ContextAffect
-(void) affectWith:(double) value_;
{
	neuron.value = value_;
}
-(void) teachAffector:(double)alpha xValue:(double)value_
{
}
-(double) getValue
{
	return 0;
}
-(void) normilizeAffect:(double)summ
{
}
-(void) debug
{
	NSLog(@" - - - %@ ContextAffect: %@", self,neuron);
}

@end
