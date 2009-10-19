//
//  Neuron.h
//  NeuroArchivator
//
//  Created by Ivan Sidarau on 16.09.09.
//  Copyright 2009 rilley_elf corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Algorythms.h"

@interface Neuron : NSObject 
{
	int length;
	double* vectorW;
}
-(Neuron*) initWithWLength:(int)length_;
- (void) dealloc;
-(double*) getVectorW;
-(double) getWByIndex:(int)index_;
-(double) getReactionOnIndex:(int)index_ value:(double)value;
-(double) getWSumm;
-(void) normilize;
@property(assign) int length;
@property(assign) double* vectorW;

@end
