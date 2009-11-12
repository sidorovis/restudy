//
//  ResultNeuronNet.h
//  SequencePredictor
//
//  Created by Ivan Sidarau on 27.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NeuroLay.h"

@interface ResultNeuronLay : NeuroLay {

}
-(void) setValuesFrom:(NSMutableArray*)sequence fromIndex:(int)startSequenceIndex;
-(void) defineGamma;

@end
