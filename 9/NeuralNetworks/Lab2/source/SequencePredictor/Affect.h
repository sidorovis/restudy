//
//  Reactor.h
//  SequencePredictor
//
//  Created by Ivan Sidarau on 23.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Affect : NSObject {
	double value;
	id to;
}
@property (assign) double value;
@property (assign) id to;
@end
