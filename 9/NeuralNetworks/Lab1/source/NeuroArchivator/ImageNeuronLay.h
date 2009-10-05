//
//  ImageNeuronLay.h
//  NeuroArchivator
//
//  Created by Ivan Sidarau on 16.09.09.
//  Copyright 2009 rilley_elf corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NeuronLay.h"
#import "ImageNeuron.h"

@interface ImageNeuronLay : NeuronLay {

}
-(NeuronLay*) initWithCount:(int)count_ nextLayCount:(int)nextLayCount_;
-(ImageNeuron*) neuronByIndex:(int)index;
-(void) teachWithInSignal:(float*)inSignal OutSignal:(float*)outSignal InitSignal:(float*)initSignal teachK:(float)teachK;
-(void) teachWithInSignal:(float*)inSignal OutSignal:(float*)outSignal LastSignal:(float*)LastSignal teachK:(float)teachK;
-(ImageNeuronLay*) copy;
@end
