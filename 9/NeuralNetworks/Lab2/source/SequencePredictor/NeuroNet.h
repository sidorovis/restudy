//
//  NeuroNet.h
//  SequencePredictor
//
//  Created by Ivan Sidarau on 23.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NeuroLay.h"

@interface NeuroNet : NSObject {
}
-(id) init;
-(void) dealloc;

-(void) teach;
-(void) teachWBetween:(NeuroLay*)from And:(NeuroLay*)to;
-(void) teachInputWithContextsWhenLevel:(int)i;
-(double) findDiff;
-(void) compute;
-(void) debug;
-(NSArray*) getResults;

@end
