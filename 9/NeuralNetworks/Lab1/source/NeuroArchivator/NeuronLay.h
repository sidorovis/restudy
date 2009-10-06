//
//  NeuronLay.h
//  NeuroArchivator
//
//  Created by Ivan Sidarau on 16.09.09.
//  Copyright 2009 rilley_elf corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Neuron.h"

@interface NeuronLay : NSObject 
{
	int count;
	int nextLayCount;
	NSObject** neurons;
	bool shouldNormilize;
}
-(NeuronLay*) initWithCount:(int)count_ nextLayCount:(int)nextLayCount_ ShouldNormilize:(bool)shouldNormilize_;

@property(assign) int count;
@property(assign) int nextLayCount;
@property(assign) NSObject** neurons;

-(void) dealloc;

-(Neuron*) neuronByIndex:(int)index;
-(float*) getAnswerOnSignal:(float*)signal;

//-(void) teachWithSignal:(float*)signal;
@end
