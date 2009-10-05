//
//  ImageNeuronLay.m
//  NeuroArchivator
//
//  Created by Ivan Sidarau on 16.09.09.
//  Copyright 2009 rilley_elf corp. All rights reserved.
//

#import "ImageNeuronLay.h"


@implementation ImageNeuronLay
-(NeuronLay*) initWithCount:(int)count_ nextLayCount:(int)nextLayCount_
{
	count = count_;
	nextLayCount = nextLayCount_;
	neurons = malloc( sizeof(ImageNeuron*) * count );
	for (int i = 0 ; i < count ; i++)
		neurons[i] = [[ImageNeuron alloc] initWithWLength:nextLayCount ];
	return self;
	
}
-(ImageNeuron*) neuronByIndex:(int)index
{
	return (ImageNeuron*)neurons[ index ];
}
-(void) teachWithInSignal:(float*)inSignal OutSignal:(float*)outSignal InitSignal:(float*)initSignal teachK:(float)teachK
{
	for(int i = 0 ; i < count ; i++)
		for (int u = 0 ; u < nextLayCount ; u++)
			[(ImageNeuron*)neurons[i] getVectorW][u] += teachK * inSignal[i] * (initSignal[u] - outSignal[u]) ;
}
-(void) teachWithInSignal:(float*)inSignal OutSignal:(float*)outSignal LastSignal:(float*)lastSignal teachK:(float)teachK
{
	for(int i = 0 ; i < count ; i++)
		for (int u = 0 ; u < nextLayCount ; u++)
			[(ImageNeuron*)neurons[i] getVectorW][u] += teachK * outSignal[u] * (inSignal[u] - lastSignal[u]) ;		
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
