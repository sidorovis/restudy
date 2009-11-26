//
//  PredictorNeuroNet.m
//  SequencePredictor
//
//  Created by Ivan Sidarau on 23.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import "DefaultBackErrorTeachingPredictorNeuroNet.h"


@implementation DefaultBackErrorTeachingPredictorNeuroNet
-(id) initWithSequence:(NSMutableArray*)sequence_ countP:(int)P_ countM:(int)M_
{
	[super init];
	P = P_;
	M = M_;
	sequence = sequence_;
	Input =  [[AcceptorNeuronLay alloc] initWithCount:P];
	Hidden = [[NeuroLay alloc] initWithCount:P*2]; 
	Result = [[ResultNeuronLay alloc] initWithCount:M];

	[Input connectEachNeuronToLay:Hidden]; 
	[Hidden connectEachNeuronToLay:Result];

	if (WITH_CONTEXTS)
	{
		HiddenContext = [Hidden generateContextLay];
		ResultContext = [Result generateContextLay];
		
		[HiddenContext connectEachNeuronToLay:Hidden];
		[ResultContext connectEachNeuronToLay:Hidden];
	}
		
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
	if (WITH_CONTEXTS)
	{
		[HiddenContext reset];
		[ResultContext reset];
	}
	for (int i = 0 ; i < input_data_count ; i++)
	{
		[Input setValuesFrom:sequence fromIndex:i];
		[Result setValuesFrom:sequence fromIndex:(i+P)];
		[self compute];
		[self teachWBetween:Hidden And:Result];
		if (WITH_CONTEXTS)
		{
			if (i == 0)
			{
				[self teachWBetween:Input And:Hidden];
			}
			else
				[self teachInputWithContextsWhenLevel:i];
		}
		else 
		{
			[self teachWBetween:Input And:Hidden];
		}
	}
}
-(void) teachInputWithContextsWhenLevel:(int)i
{
	if (WITH_CONTEXTS)
	{
		[HiddenContext resetGammaValue];
		[ResultContext resetGammaValue];
		double alpha = [Input getXSumm];
		alpha += [HiddenContext getXSumm];
		alpha += [ResultContext getXSumm];
		alpha = 1.0 / (alpha);
		[Input teachLayWithAlpha:alpha];
		[HiddenContext teachLayWithAlpha:alpha];
		[ResultContext teachLayWithAlpha:alpha];
		
		if ( false && i > 0) // TODO: possible recursive error counting needed
		{
			for (Neuron* fromNeuron in [HiddenContext neurons])
				[fromNeuron calculateGammaValue];
			[Hidden copyGammaFromContext:HiddenContext];
			[self teachInputWithContextsWhenLevel:i-1];
		}		
	}
}
-(void) teachWBetween:(NeuroLay*)from And:(NeuroLay*)to
{
	[from resetGammaValue];
	double alpha = [from getXSumm];
	alpha = 1.0 / (alpha);
	[from teachLayWithAlpha:alpha];
	[from recalculateGamma];
}

-(double) findDiff
{
	double diff = 0;
	if (WITH_CONTEXTS)
	{
		[HiddenContext reset];
		[ResultContext reset];
	}
	int input_data_count = 1 + [sequence count] - P - M;
	for (int i = 0 ; i < input_data_count ; i++)
	{
		[Input setValuesFrom:sequence fromIndex:i];
		[Result setValuesFrom:sequence fromIndex:(i+P)]; 
		[self compute];
		for (Neuron* resultNeuron in [Result neurons]) {
			diff += fabs( [resultNeuron gammaValue] );
		}
	}
	[self debug];
	return diff;
}

-(void) compute
{
	[Result reset];
	[Hidden reset];
	[Input affect];
	if (WITH_CONTEXTS)
	{
		[HiddenContext affect];
		[ResultContext affect];
	}
	[Hidden activateFunc];
	[Hidden affect];
	[Result activateFunc];
	[Result affect];
	[Result defineGamma];
}
-(void) debug
{
	if (SHOW_DEBUG)
	{
		NSLog(@"PredictorNeuroNet");
		[Input debug];
		[Hidden debug];
		[Result debug];
		[HiddenContext debug];
		[ResultContext debug];		
	}
}
-(NSArray*) getResults
{
	NSMutableArray* result = [[NSMutableArray alloc] init];
	[result addObjectsFromArray:sequence];
	[self findDiff];
	for (int i = 0 ; i < PREDICT_COUNT ; i++)
	{
		[Input setValuesFrom:result fromIndex:[result count] - P];
		[self compute];
		for (Neuron* neuron in [Result neurons]) {
			[result addObject:[[NSNumber alloc] initWithDouble:neuron.value]];
		}
	}
	return result;
}
@end
