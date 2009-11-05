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
#import "ResultNeuronLay.h"
#import "math.h"

@interface PredictorNeuroNet : NeuroNet {
	AcceptorNeuronLay *Input;
	ResultNeuronLay *Result;
	NeuroLay *Hidden, *HiddenContext, *ResultContext;
	NSMutableArray* sequence;
	int P, M;
}
-(id) initWithSequence:(NSMutableArray*)sequence_ countP:(int)P_ countM:(int)M_;
-(void) dealloc;
-(void) teach;
-(void) teachWBetween:(NeuroLay*)from And:(NeuroLay*)to;
-(double) findDiff;
-(void) compute;
-(void) debug;
@end
