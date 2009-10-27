//
//  ResultNeuronNet.m
//  SequencePredictor
//
//  Created by Ivan Sidarau on 27.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import "ResultNeuronLay.h"


@implementation ResultNeuronLay
-(void) setValuesFrom:(NSMutableArray*)sequence fromIndex:(int)startSequenceIndex;
{
	int neurons_count = [neurons count];
	if (startSequenceIndex + neurons_count > [sequence count])
		@throw [[NSException alloc] initWithName:@"Assign Input Neurons Error" reason:@"Sequence don't have such values" userInfo:NULL];
	for (int i = 0 ; i < neurons_count ; i++)
		((Neuron*)[neurons objectAtIndex:i]).trueValue = [[sequence objectAtIndex:(startSequenceIndex+i)] doubleValue];		
}

@end
