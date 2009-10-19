//
//  NeuronLay.m
//  NeuroArchivator
//
//  Created by Ivan Sidarau on 16.09.09.
//  Copyright 2009 rilley_elf corp. All rights reserved.
//

#import "NeuronLay.h"


@implementation NeuronLay
-(NeuronLay*) initWithCount:(int)count_ nextLayCount:(int)nextLayCount_ ShouldNormilize:(bool)shouldNormilize_
{
	[super init];
	shouldNormilize = shouldNormilize_;
	count = count_;
	nextLayCount = nextLayCount_;
	neurons = malloc( sizeof(Neuron*) * count );
	for (int i = 0 ; i < count ; i++)
		neurons[i] = [[Neuron alloc] initWithWLength:nextLayCount ];
	return self;
}

@synthesize count;
@synthesize nextLayCount;
@synthesize neurons;


-(void) dealloc
{	
	for (int i = 0 ; i < count ; i++)
		[neurons[i] release];
	free( neurons );
	[super dealloc];
}
-(Neuron*) neuronByIndex:(int)index
{
	return (Neuron*)neurons[ index ];
}
-(double*) getAnswerOnSignal:(double*)signal
{
	double* answer = malloc( sizeof(double) * nextLayCount );
	for (int i = 0 ; i < nextLayCount ; i++)
		answer[i] = 0;
	double summ = 0;
	for (int i = 0 ; i < count ; i++)
		for (int u = 0 ; u < nextLayCount ; u++)
		{
			answer[u] += [((Neuron*)neurons[i]) getReactionOnIndex:u value:signal[i]];
			summ += fabs(answer[u]);
			if (isnan(answer[u]))
				@throw [NSException exceptionWithName:@"nan exception" reason:@"w koefficients was not normilized" userInfo:nil];
			if (isinf(answer[u]))
				@throw [NSException exceptionWithName:@"infinitive exception" reason:@"w koefficients was not normilized" userInfo:nil];
		}
	
	return answer;
}

@end
