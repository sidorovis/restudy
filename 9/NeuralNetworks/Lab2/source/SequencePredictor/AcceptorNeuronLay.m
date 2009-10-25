//
//  AcceptorNeuronLay.m
//  SequencePredictor
//
//  Created by Ivan Sidarau on 24.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import "AcceptorNeuronLay.h"


@implementation AcceptorNeuronLay
-(void) setValuesFrom:(NSMutableArray*)sequence fromIndex:(int)startSequenceIndex;
{
	if (startSequenceIndex + [neurons count] > [sequence count])
		@throw [[NSException alloc] initWithName:@"Assign Input Neurons Error" reason:@"Sequence don't have such values" userInfo:NULL];
	for (int i = 0 ; i < [neurons count] ; i++)
		((Neuron*)[neurons objectAtIndex:i]).value = [[sequence objectAtIndex:(startSequenceIndex+i)] doubleValue];
}

@end
