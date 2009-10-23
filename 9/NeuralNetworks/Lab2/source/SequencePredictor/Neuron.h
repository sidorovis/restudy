//
//  Neuron.h
//  SequencePredictor
//
//  Created by Ivan Sidarau on 23.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Neuron : NSObject 
{
	NSMutableArray* affectOn;
	double value;
//	double nextValue;
}
- (id) init;
- (void) dealloc;
- (void) connectRandomAffectToLay:(Neuron*)neuron_;
- (void) connectContextAffectToLay:(Neuron*)neuron_;
@property (assign) double value;
//@property (assign) double nextValue;

@end
