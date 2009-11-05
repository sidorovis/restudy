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
//		if (neuroNet)
//			[neuroNet release];
		neuroNet = [[PredictorNeuroNet alloc] initWithSequence:sequence countP:p countM:m];
//		if (thread)
//			[thread release];
//		thread = [[NSThread alloc] initWithTarget:self selector:@selector(arch) object:nil];
//		[start setEnabled:YES];
//		[generate setEnabled:NO];
//		NSLog(@"%d, %d, %d", p, m, [sequence count]);
		[self arch];
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
		[currentDiff setDoubleValue:diff];
		if ([thread isCancelled])
			break;
	}	
	[pool drain];
	[thread release];
	thread = NULL;
	[stop setEnabled:NO];
	[generate setEnabled:YES];
}
- (IBAction)start:(id)sender
{
	if (thread)
	{
		[thread start];
		[generate setEnabled:NO];
		[stop setEnabled:YES];
		[start setEnabled:NO];		
	}
}
- (IBAction)stop:(id)sender
{
	if (thread && [thread isExecuting])
	{
		[thread cancel];
	}
}

@end
