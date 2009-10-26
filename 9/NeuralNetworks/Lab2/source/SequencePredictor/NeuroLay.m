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
			[from connectRandomAffectToNeuron:to];
		}
	}
}
-(NeuroLay*) generateContextLay
{
	NeuroLay* context = [[NeuroLay alloc] initWithCount:[neurons count]];
	for (int i = 0 ; i < [neurons count] ; i++)
		[[neurons objectAtIndex:i] connectContextAffectToNeuron:[context.neurons objectAtIndex:i]];
	return context;
}

-(void) affect
{
	for (Neuron* neuron in neurons) {
		[neuron affect];
	}
}
-(Neuron*) getNeuronAtIndex:(int)index
{
	return (Neuron*)[neurons objectAtIndex:index];
}
-(void) normilizeLay
{
	for (Neuron* neuron in neurons) {
		[neuron normilizeNeuron];
	}
}

@synthesize neurons;

@end
