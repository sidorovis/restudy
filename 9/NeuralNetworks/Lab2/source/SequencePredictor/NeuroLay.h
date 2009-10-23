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
-(void) connectEachToLay:(NeuroLay*)lay;
-(void) affect;

@property (readwrite,assign) NSMutableArray* neurons;

@end
