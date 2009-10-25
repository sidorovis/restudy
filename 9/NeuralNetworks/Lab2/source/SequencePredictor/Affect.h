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
	Neuron* neuron;
}
@property (assign) Neuron* neuron;

-(Affect*) initToNeuron:(Neuron*)neuron_;
-(void) dealloc;

@end
