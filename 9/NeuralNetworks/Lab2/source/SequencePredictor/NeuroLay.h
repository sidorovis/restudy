//
//  NeuroLay.h
//  SequencePredictor
//
//  Created by Ivan Sidarau on 23.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Neuron.h"

@interface NeuroLay : NSObject {
	NSMutableArray* neurons;
}
-(id) initWithCount:(int)count;
-(void) dealloc;
-(void) reset;
-(void) resetGammaValue;
-(void) connectEachNeuronToLay:(NeuroLay*)lay;
-(void) connectEachContextNeuronToLay:(NeuroLay*)lay;
-(NeuroLay*) generateContextLay;
-(void) affect;
-(Neuron*) getNeuronAtIndex:(int)index;
@property (readwrite,assign) NSMutableArray* neurons;
-(void) debug;
-(void) copyGammaFromContext:(NeuroLay*)context;
-(void) teachLayWithAlpha:(double)alpha;
-(void) recalculateGamma;
-(double) getXSumm;
@end
