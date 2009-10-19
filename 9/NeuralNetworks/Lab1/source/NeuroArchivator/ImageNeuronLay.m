//
//  ImageNeuronLay.m
//  NeuroArchivator
//
//  Created by Ivan Sidarau on 16.09.09.
//  Copyright 2009 rilley_elf corp. All rights reserved.
//

#import "ImageNeuronLay.h"


@implementation ImageNeuronLay
-(NeuronLay*) initWithCount:(int)count_ nextLayCount:(int)nextLayCount_ ShouldNormilize:(bool)shouldNormilize_
{
	count = count_;
	nextLayCount = nextLayCount_;
	shouldNormilize = shouldNormilize_;
	neurons = malloc( sizeof(ImageNeuron*) * count );
	for (int i = 0 ; i < count ; i++)
		neurons[i] = [[ImageNeuron alloc] initWithWLength:nextLayCount];
	return self;
	
}
-(double) getWSumm
{
	double summ = 0;
	for (int i = 0 ; i < count ; i++)
		summ += [(ImageNeuron*)neurons[i] getWSumm];
	return summ;
}
-(double) getAdaptiveTeachK
{
	return 1.0/(1.0+fabs([self getWSumm]));
}

-(ImageNeuron*) neuronByIndex:(int)index
{
	return (ImageNeuron*)neurons[ index ];
}
-(void) teachWithInSignal:(double*)inSignal OutSignal:(double*)outSignal InitSignal:(double*)initSignal teachK:(double)teachK
{
	for(int i = 0 ; i < count ; i++)
	{
		for (int u = 0 ; u < nextLayCount ; u++)
		{
			assert(!isnan(teachK * inSignal[i] * (initSignal[u] - outSignal[u])));
			[(ImageNeuron*)neurons[i] getVectorW][u] += teachK * inSignal[i] * (initSignal[u] - outSignal[u]) ;
		}
		if (shouldNormilize)
			[(ImageNeuron*)neurons[i] normilize];
	}
}
-(void) teachWithInSignal:(double*)inSignal OutSignal:(double*)outSignal LastSignal:(double*)lastSignal teachK:(double)teachK
{
	for(int i = 0 ; i < count ; i++)
	{
		for (int u = 0 ; u < nextLayCount ; u++)
		{
			assert(!isnan( teachK * outSignal[u] * (inSignal[u] - lastSignal[u]) ));
			[(ImageNeuron*)neurons[i] getVectorW][u] += teachK * outSignal[u] * (inSignal[u] - lastSignal[u]) ;		
		}
		if (shouldNormilize)
			[(ImageNeuron*)neurons[i] normilize];
	}
}
-(ImageNeuronLay*) copy
{
	ImageNeuronLay* new = [[ImageNeuronLay alloc] init];
	new.count = count;
	new.nextLayCount = nextLayCount;
	new.neurons = malloc( sizeof(ImageNeuron*) * count );
	for (int i = 0 ; i < count ; i++)
	{
		new.neurons[i] = [neurons[i] copy];
	}
	return new;	
}
-(NSString*)description
{
	NSString* res = @"";
	for (int i = 0 ; i < count ; i++)
		res = [res stringByAppendingFormat:@"%@", neurons[i]];
	return res;
}
@end
