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
	Hidden = [[NeuroLay alloc] initWithCount:P_];
	Result = [[NeuroLay alloc] initWithCount:M_];

	[Input connectEachToLay:Hidden];
	[Hidden connectEachToLay:Result];
	
	HiddenContext = [Hidden generateContextLay];
	ResultContext = [Result generateContextLay];
	
	[HiddenContext connectEachToLay:Hidden];
	[ResultContext connectEachToLay:Hidden];
	
	[Input normilize];
	[Hidden normilize];
	[Result normilize];
	[HiddenContext normilize];
	[ResultContext normilize];
	
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
-(void)initLayWithSequenceValue:(int)startSequenceIndex
{
	[Input setValuesFrom:sequence fromIndex:startSequenceIndex];
}
-(void) teach
{
	int input_data_count = 1 + [sequence count] - [[Input neurons] count] - [[Result neurons] count];
	[HiddenContext reset];
	[ResultContext reset];
	for (int i = 0 ; i < input_data_count ; i++)
	{
		[self initLayWithSequenceValue:i];
		[self compute];
		[self teachHiddenResultConnectionWhenSequenceFrom:i];
	}
}
-(void) teachHiddenResultConnectionWhenSequenceFrom:(int)ind;
{
	int P = [[Hidden neurons] count];
	int M = [[Result neurons] count];
	double alpha = 0;
	for (Neuron* neuron in Hidden.neurons) {
		alpha += neuron.value;
	}
	alpha = 1.0 / (1.0 + alpha);
	for (int u = 0 ; u < M ; u++)
	{
		Neuron* toNeuron = [Result getNeuronAtIndex:u];
		double Y = [toNeuron value];
		double trueY = [(NSNumber*)[sequence objectAtIndex:(P+ind+u)] doubleValue];
		double deltaY = trueY - Y;
		for (int i = 0 ; i < P ; i++)
		{
			Neuron* current = [Hidden getNeuronAtIndex:i];
			[current teachTo:toNeuron alpha:alpha deltaY:deltaY];
		}
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
		[self initLayWithSequenceValue:i];
		[self compute];
		for (int u = 0 ; u < M ; u++)
		{
			double result = [[Result getNeuronAtIndex:u] value];
			double true_result = [(NSNumber*)[sequence objectAtIndex:(P+i+u)] doubleValue];
			diff += fabs( result - true_result );
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
