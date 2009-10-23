//
//  AcceptorNeuronLay.h
//  SequencePredictor
//
//  Created by Ivan Sidarau on 24.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NeuroLay.h"

@interface AcceptorNeuronLay : NeuroLay {

}
-(void) initWithSequence:(NSMutableArray*)sequence fromIndex:(int)startSequenceIndex;

@end
