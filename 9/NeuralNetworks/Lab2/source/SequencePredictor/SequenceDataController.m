//
//  SequenceDataController.m
//
//  Created by Ivan Sidarau on 22.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import "SequenceDataController.h"


@implementation SequenceDataController
+(void)init
{
	[super initialize];
}
- (IBAction)predict:(id)sender
{
	if (!thread || ![thread isExecuting])
	@try {
		p = validateInt(@"P", [P stringValue]);
		m = validateInt(@"M", [M stringValue]);
		e_min = validateDouble(@"E", [Emin stringValue]);
		if (sequence)
			[sequence release];
		sequence = [[NSMutableArray alloc] init];
		for (NSString* string in [[sequenceField stringValue] componentsSeparatedByString:@" "])
			[sequence addObject:[[NSNumber alloc] initWithDouble:( 
								func_in( validateDouble(@"Sequence value wrong", string) )
																  )]];
		if (p+m > [sequence count])
			@throw [[NSException alloc] initWithName:@"P+M must be lower than sequence count" reason:@"p, m, sequence fields" userInfo:NULL];
		if (neuroNet)
			[neuroNet release];
		neuroNet = [self getNeuroNet];
		if (USE_DEFAULT_BACK_PROPAGATION_ALGORYTHM)
			neuroNet = [[DefaultBackErrorTeachingPredictorNeuroNet alloc] initWithSequence:sequence countP:p countM:m];
		else
			neuroNet = [[ForwardStepTeachingPredictorNeroNet alloc] initWithSequence:sequence countP:p countM:m];
		if (thread)
			[thread release];
		thread = [[NSThread alloc] initWithTarget:self selector:@selector(arch) object:nil];
		[start setEnabled:YES];
		[generate setEnabled:NO];
		[self disableTextFields];
		[getResultButton setEnabled:NO];
	}
	@catch (NSException * e) {
		NSRunAlertPanel([e name], [e reason], @"Ok", NULL, NULL);
	}
	@finally {
		
	}
	else
		NSRunAlertPanel(@"Thread is working, stop it first.", @"Warning", @"Ok", NULL, NULL);
}
-(void) arch
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	double diff = [neuroNet findDiff];
	double min_diff = MAX_DOUBLE;
	while (diff > e_min)
	{
		[neuroNet teach];
		diff = [neuroNet findDiff];
		if (diff >= e_min)
		{
			if (diff / min_diff > 10 || diff > 1000)
			{
				NSLog(@"NeuroNet differencies go to max to fast, redefininig neuro net");
				[neuroNet release];
				neuroNet = [self getNeuroNet];
				[neuroNet release];
				neuroNet = [self getNeuroNet];
			}
		}
		if (diff < min_diff)
			min_diff = diff;
		[currentDiff setStringValue:[[NSString alloc] initWithFormat:@"%0*.*f", diff]];
		if ([thread isCancelled])
			break;
	}	
	[pool drain];
	[thread release];
	thread = NULL;
	[stop setEnabled:NO];
	[generate setEnabled:YES];
	[workIndicator stopAnimation:self];	
	[getResultButton setEnabled:YES];
	[self enableTextFields];
}
- (IBAction)start:(id)sender
{
	if (thread)
	{
		[thread start];
		[generate setEnabled:NO];
		[stop setEnabled:YES];
		[start setEnabled:NO];		
		[workIndicator startAnimation:self];
	}
}
- (IBAction)stop:(id)sender
{
	[self enableTextFields];
	[workIndicator stopAnimation:self];
	[getResultButton setEnabled:YES];
	if (thread && [thread isExecuting])
	{
		[thread cancel];
	}
}
-(void) disableTextFields
{
	[sequenceField setEnabled:NO];
	[P setEnabled:NO];
	[M setEnabled:NO];
	[Emin setEnabled:NO];
}
-(void) enableTextFields
{
	[sequenceField setEnabled:YES];
	[P setEnabled:YES];
	[M setEnabled:YES];
	[Emin setEnabled:YES];
}
-(IBAction)getResults:(id)sender
{
	NSArray* result = [neuroNet getResults];

	NSString *tstr = @"";
	for (int i = 0 ; i < [result count]; i++)
		tstr = [tstr stringByAppendingFormat:@"%f\n", 
				func_out( [[result objectAtIndex:i] doubleValue] )
				];
	[result release];
	[resultView setString: tstr];
}
-(NeuroNet*) getNeuroNet
{
	NeuroNet* neuroNet_;
	if (USE_DEFAULT_BACK_PROPAGATION_ALGORYTHM)
		neuroNet_ = [[DefaultBackErrorTeachingPredictorNeuroNet alloc] initWithSequence:sequence countP:p countM:m];
	else
		neuroNet_ = [[ForwardStepTeachingPredictorNeroNet alloc] initWithSequence:sequence countP:p countM:m];
	return neuroNet_;
}

@end
