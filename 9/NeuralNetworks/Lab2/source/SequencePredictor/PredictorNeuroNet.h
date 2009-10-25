 //
//  PredictorNeuroNet.h
//  SequencePredictor
//
//  Created by Ivan Sidarau on 23.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NeuroNet.h"
#import "AcceptorNeuronLay.h"
#import "math.h"

@interface PredictorNeuroNet : NeuroNet {
	AcceptorNeuronLay *Input;
	NeuroLay *Hidden, *HiddenContext, *Result, *ResultContext;
	NSMutableArray* sequence;
}
-(id) initWithSequence:(NSMutableArray*)sequence_ countP:(int)P_ countM:(int)M_;
-(void) dealloc;
-(void) initLayWithSequenceValue:(int)startSequenceIndex;
-(void) teach;
-(void) teachHiddenResultConnectionWhenSequenceFrom:(int)ind;
-(double) findDiff;
-(void) compute;
@end
