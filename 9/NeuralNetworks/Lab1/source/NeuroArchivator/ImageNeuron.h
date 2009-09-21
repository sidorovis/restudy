//
//  ImageNeuron.h
//  NeuroArchivator
//
//  Created by Ivan Sidarau on 16.09.09.
//  Copyright 2009 rilley_elf corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NeuronLay.h"

@interface ImageNeuron : Neuron {
	int index;
}
-(ImageNeuron*) initWithIndex:(int)index_ length:(int)length_;
-(ImageNeuron*) copy;

@property(assign) int index;
@end
