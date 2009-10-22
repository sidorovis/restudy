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
-(NeuronLay*) initWithCount:(int)count_ nextLayCount:(int)nextLayCount_ ShouldNormilize:(bool)shouldNormilize_;
-(ImageNeuron*) neuronByIndex:(int)index;
-(void) teachWithInSignal:(double*)inSignal OutSignal:(double*)outSignal InitSignal:(double*)initSignal teachK:(double)teachK;
-(ImageNeuronLay*) copy;
-(double) getWSumm;
-(double) getAdaptiveTeachK;
@end
