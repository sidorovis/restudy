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
-(void) increaseValue:(double) delta
{
}
-(double) getValue
{
	return 1;
}
-(void) normilize:(double)summ
{
}

@end
