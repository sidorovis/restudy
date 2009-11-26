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

#define PREDICT_COUNT 15
#define WITH_CONTEXTS true
#define SHOW_DEBUG false

@interface DefaultBackErrorTeachingPredictorNeuroNet : NeuroNet {
	AcceptorNeuronLay *Input;
	ResultNeuronLay *Result;
	NeuroLay *Hidden;
	NeuroLay *HiddenContext, *ResultContext;
	NSMutableArray* sequence;
	int P, M;
}
-(id) initWithSequence:(NSMutableArray*)sequence_ countP:(int)P_ countM:(int)M_;
-(void) dealloc;
@end
