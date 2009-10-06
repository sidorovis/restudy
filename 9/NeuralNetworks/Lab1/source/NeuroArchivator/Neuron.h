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
	float* vectorW;
}
-(Neuron*) initWithWLength:(int)length_;
- (void) dealloc;
-(float*) getVectorW;
-(float) getWByIndex:(int)index_;
-(float) getReactionOnIndex:(int)index_ value:(float)value;
-(float) getWSumm;
@property(assign) int length;
@property(assign) float* vectorW;

@end
