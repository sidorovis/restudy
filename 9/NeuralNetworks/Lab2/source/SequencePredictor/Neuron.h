//
//  Neuron.h
//  SequencePredictor
//
//  Created by Ivan Sidarau on 23.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Neuron : NSObject 
{
	NSMutableArray* affectOnArray;
	double value;
	double trueValue;
//	double nextValue;
}
- (id) init;
- (void) dealloc;
- (void) connectRandomAffectToNeuron:(Neuron*)neuron_;
- (void) connectContextAffectToNeuron:(Neuron*)neuron_;
- (void) affect;
- (void) teachTo:(Neuron*)toNeuron alpha:(double)alpha deltaY:(double)deltaY;
- (void) normilizeNeuron;
- (double) getDiff;
@property (assign) double value;
@property (assign) double trueValue;
//@property (assign) double nextValue;

@end
