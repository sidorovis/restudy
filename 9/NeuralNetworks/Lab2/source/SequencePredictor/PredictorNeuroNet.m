//
//  PredictorNeuroNet.m
//  SequencePredictor
//
//  Created by Ivan Sidarau on 23.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import "PredictorNeuroNet.h"


@implementation PredictorNeuroNet
-(id) initWithSequence:(NSMutableArray*)sequence_ countP:(int)P_ countM:(int)M_
{
	[super init];
	P = P_;
	M = M_;
	sequence = sequence_;
	Input =  [[AcceptorNeuronLay alloc] initWithCount:P];
	Hidden = [[NeuroLay alloc] initWithCount:P]; 
	Result = [[ResultNeuronLay alloc] initWithCount:M];

	[Input connectEachNeuronToLay:Hidden]; 
	[Hidden connectEachNeuronToLay:Result];
	
	HiddenContext = [Hidden generateContextLay];
	ResultContext = [Result generateContextLay];
	
	[HiddenContext connectEachNeuronToLay:Hidden];
	[ResultContext connectEachNeuronToLay:Hidden];
		
	return self;
}
-(void) dealloc
{
	[sequence retain];
	[Input release];
	[Hidden release];
	[Result release];
	[super dealloc];
}
-(void) teach
{
	int input_data_count = 1 + [sequence count] - P - [[Result neurons] count];
	[HiddenContext reset];
	[ResultContext reset];
	for (int i = 0 ; i < input_data_count ; i++)
	{
		[Input setValuesFrom:sequence fromIndex:i];
		[Result setValuesFrom:sequence fromIndex:(i+P)];
		[self compute];
		[self teachWBetween:Hidden And:Result];
		// TODO: teach Input -> Hidden W levels
//		[self teachWBetween:Input And:Hidden];
	}
}
-(void) teachWBetween:(NeuroLay*)from And:(NeuroLay*)to
{
	[from resetGammaValue];
	double alpha = 0;
	for (Neuron* neuron in from.neurons)
		alpha += neuron.value * neuron.value;
	alpha = 1.0 / (alpha);
	for (Neuron* fromNeuron in [from neurons])
		[fromNeuron teachWithAlpha:alpha];
	for (Neuron* fromNeuron in [from neurons])
		[fromNeuron calculateGammaValue];
}

-(double) findDiff
{
	double diff = 0;
	[HiddenContext reset];
	[ResultContext reset];
	int input_data_count = 1 + [sequence count] - P - M;
	for (int i = 0 ; i < input_data_count ; i++)
	{
		[Input setValuesFrom:sequence fromIndex:i];
		[Result setValuesFrom:sequence fromIndex:(i+P)]; 
		[self compute];
		for (Neuron* resultNeuron in [Result neurons]) {
			diff += fabs( [resultNeuron getDiff] );
		}
	}
	return diff;
}

-(void) compute
{
	[Hidden reset];
	[Result reset];
	
	[Input affect];
	[HiddenContext affect];
	[ResultContext affect];

	[Hidden affect];
	[Result affect];
}
@end
