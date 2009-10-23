//
//  Neuron.h
//  SequencePredictor
//
//  Created by Ivan Sidarau on 23.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Affect.h"

@interface Neuron : NSObject {
	NSMutableArray* affectors;
}
- (Neuron*) init;
- (void) dealloc;
@end
