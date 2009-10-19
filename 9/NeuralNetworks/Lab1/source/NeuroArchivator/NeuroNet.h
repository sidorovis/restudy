//
//  W.h
//  NeuroArchivator
//
//  Created by Ivan Sidarau on 10.09.09.
//  Copyright 2009 rilley_elf corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NeuronLay.h"

@interface NeuroNet : NSObject 
{
	
	double teachK; // alpha, or koefficient 
	double enoughK; // D

	int layCount;
	NSObject** lays;
	NSObject** saveLays;
}
- (void) dealloc;
- (BOOL) goodEnough;
- (void) teach;
//- (void) saveState;
//- (void) loadState;
@end
