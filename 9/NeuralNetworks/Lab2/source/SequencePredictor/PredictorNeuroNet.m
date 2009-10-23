//
//  PredictorNeuroNet.m
//  SequencePredictor
//
//  Created by Ivan Sidarau on 23.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import "PredictorNeuroNet.h"


@implementation PredictorNeuroNet
-(id) initWithSequence:(NSMutableArray*)sequence_ countP:(int)P_ countM:(int)M_
{
	[super init];
	sequence = sequence_;
	Input = [[NeuroLay alloc] initWithCount:P_];
	HiddenContext = [[NeuroLay alloc] initWithCount:P_];
	ResultContext = Result = [[NeuroLay alloc] initWithCount:M_];
	Hidden = [[NeuroLay alloc] initWithCount:P_];
	Result = [[NeuroLay alloc] initWithCount:M_];

	[Input connectEachToLay:Hidden];
	[Hidden connectEachToLay:Result];
	
	return self;
}
-(void) dealloc
{
	[sequence retain];
	[Input release];
	[Hidden release];
	[Result release];
	[super dealloc];
}
-(void)initLayWithSequenceValue:(int)startSequenceIndex
{
	[Input initWithSequence:sequence fromIndex:startSequenceIndex];
}
-(void) teach
{
	int input_data_count = [sequence count] - [[Input neurons] count];
	for (int i = 0 ; i < input_data_count ; i++)
	{
		[self initLayWithSequenceValue:i];
		[self compute];
	}
}
-(void) compute
{
//	[Hidden reset];
//	[Result reset];
//	[Input affect];
//	[Hidden affect];
//	[Result affect];
//	[Hidden baseValue];
//	[Result baseValue];
	
}
@end
