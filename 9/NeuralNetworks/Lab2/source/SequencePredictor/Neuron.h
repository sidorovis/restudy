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
	double gammaValue;
}
- (id) init;
- (void) dealloc;
- (void) connectRandomAffectToNeuron:(Neuron*)neuron_;
- (void) connectContextAffectToNeuron:(Neuron*)neuron_;
- (void) affect;
- (void) teachWithAlpha:(double)alpha;
- (void) calculateGammaValue;
- (double) getDiff;
@property (assign) double value;
@property (assign) double gammaValue;

@end
