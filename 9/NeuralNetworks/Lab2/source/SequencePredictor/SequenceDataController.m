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
		int p = validateInt(@"P", [P stringValue]);
		int m = validateInt(@"M", [M stringValue]);
		e_min = validateDouble(@"E", [Emin stringValue]);
		NSMutableArray* sequence = [[NSMutableArray alloc] init];
		for (NSString* string in [[sequenceField stringValue] componentsSeparatedByString:@" "])
			[sequence addObject:[[NSNumber alloc] initWithDouble:validateDouble(@"Sequence value wrong", string)]];
		if (p+m > [sequence count])
			@throw [[NSException alloc] initWithName:@"P+M must be lower than sequence count" reason:@"p, m, sequence fields" userInfo:NULL];
		if (neuroNet)
			[neuroNet release];
			neuroNet = [[PredictorNeuroNet alloc] initWithSequence:sequence countP:p countM:m];
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
	while (diff > e_min)
	{
		[neuroNet teach];
		diff = [neuroNet findDiff];
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
	[resultView setString: [neuroNet getResults]];
}

@end
