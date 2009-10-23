//
//  NeuroLay.m
//  SequencePredictor
//
//  Created by Ivan Sidarau on 23.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import "NeuroLay.h"


@implementation NeuroLay

-(id) initWithCount:(int)count
{
	[super init];
	neurons = [[NSMutableArray alloc] init];
	for (int i = 0 ; i < count ; i++)
		[neurons addObject:[[Neuron alloc] init]];
	return self;
}
-(void) dealloc
{
	[neurons release];
	[super dealloc];
}
-(void) reset
{
	for (Neuron* neuron in neurons) {
		neuron.value = 0;
	}
}
-(void) connectEachToLay:(NeuroLay*)lay
{
	for (Neuron* from in neurons) {
		for (Neuron* to in lay.neurons) {
//			[from connectTo:to];
		}
	}
}
-(void) affect
{
	for (Neuron* neuron in neurons) {
//		[neuron affect]; 
		// TODO !
	}
}

@synthesize neurons;

@end
