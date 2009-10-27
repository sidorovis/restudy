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
	sequence = sequence_;
	Input = [[AcceptorNeuronLay alloc] initWithCount:P_];
	Hidden = [Input generateContextLay];
//	Hidden = [[NeuroLay alloc] initWithCount:P_]; 
	// TODO: hidden is context
	Result = [[ResultNeuronLay alloc] initWithCount:M_];

//	[Input connectEachNeuronToLay:Hidden]; 
	// TODO: hidden is context
	[Hidden connectEachNeuronToLay:Result];
	
	HiddenContext = [Hidden generateContextLay];
	ResultContext = [Result generateContextLay];
	
	[HiddenContext connectEachNeuronToLay:Hidden];
	[ResultContext connectEachNeuronToLay:Hidden];
	
//	[Input normilizeLay];
//	[Hidden normilizeLay];
//	[Result normilizeLay];
//	[HiddenContext normilizeLay];
//	[ResultContext normilizeLay];
	
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
	int input_data_count = 1 + [sequence count] - [[Input neurons] count] - [[Result neurons] count];
	[HiddenContext reset];
	[ResultContext reset];
	for (int i = 0 ; i < input_data_count ; i++)
	{
		[Input setValuesFrom:sequence fromIndex:i];
		[Result setValuesFrom:sequence fromIndex:i];
		[self compute];
		[self teachHiddenResultConnectionWhenSequenceFrom:i];
//		[self teachInputHiddenConnection
	}
}
-(void) teachHiddenResultConnectionWhenSequenceFrom:(int)ind;
{
	int P = [[Hidden neurons] count];
	int M = [[Result neurons] count];
	double alpha = 0;
	for (Neuron* neuron in Hidden.neurons) {
		alpha += neuron.value*neuron.value;
	}
	alpha = 1.0 / (alpha);
	for (int u = 0 ; u < M ; u++)
	{
		Neuron* toNeuron = [Result getNeuronAtIndex:u];
		double deltaY = -([(NSNumber*)[sequence objectAtIndex:(P+ind+u)] doubleValue] - toNeuron.value);
		for (int i = 0 ; i < P ; i++)
			[[Hidden getNeuronAtIndex:i] teachTo:toNeuron alpha:alpha deltaY:deltaY];
	}
}

-(double) findDiff
{
	double diff = 0;
	int P = [[Input neurons] count];
	int M = [[Result neurons] count];
	[HiddenContext reset];
	[ResultContext reset];
	int input_data_count = 1 + [sequence count] - P - M;
	for (int i = 0 ; i < input_data_count ; i++)
	{
		[Input setValuesFrom:sequence fromIndex:i];
		[Result setValuesFrom:sequence fromIndex:i+P]; 
		[self compute];
		for (int u = 0 ; u < M ; u++)
			diff += fabs( [[Result getNeuronAtIndex:u] getDiff] );
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
