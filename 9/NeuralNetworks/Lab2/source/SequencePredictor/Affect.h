//
//  Reactor.h
//  SequencePredictor
//
//  Created by Ivan Sidarau on 23.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Neuron.h"

@interface Affect : NSObject {
	double value;
	Neuron* neuron;
}
@property (assign) double value;
@property (assign) Neuron* neuron;

-(Affect*) initWithValue:(double)value_ toNeuron:(Neuron*)neuron_;
-(void) dealloc;
@end
