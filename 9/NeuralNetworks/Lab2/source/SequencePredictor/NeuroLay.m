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
	for (Neuron* neuron in neurons)
		neuron.value = 0;
}
-(void) resetGammaValue
{
	for (Neuron* neuron in neurons)
		neuron.gammaValue = 0;
}

-(void) connectEachNeuronToLay:(NeuroLay*)lay
{
	for (Neuron* from in neurons)
		for (Neuron* to in lay.neurons)
			[from connectRandomAffectToNeuron:to];
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
	for (Neuron* neuron in neurons)
		[neuron affect];
}
-(Neuron*) getNeuronAtIndex:(int)index
{
	return (Neuron*)[neurons objectAtIndex:index];
}

@synthesize neurons;

-(void) debug
{
	NSLog(@" - NeuronLay: ");
	for (Neuron* neuron in neurons) {
		[neuron debug];
	}
}
-(void) copyGammaFromContext:(NeuroLay*)context
{
  	for (int i = 0 ; i < [neurons count] ; i++)
		[self getNeuronAtIndex:i].gammaValue = [context getNeuronAtIndex:i].gammaValue;
}
-(void) teachLayWithAlpha:(double)alpha
{
	for (Neuron* fromNeuron in neurons)
		[fromNeuron teachWithAlpha:alpha];
}
-(void) recalculateGamma
{
	for (Neuron* fromNeuron in neurons)
		[fromNeuron calculateGammaValue];	
}
-(double) getXSumm
{
	double alpha = 0;
	for (Neuron* fromNeuron in neurons)
		alpha += fromNeuron.value*fromNeuron.value;
	return alpha;
}

@end
