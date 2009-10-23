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
	@try {
		int p = validateInt(@"P", [P stringValue]);
		int m = validateInt(@"M", [M stringValue]);
		NSArray* strSequenceArray = [[sequenceField stringValue] componentsSeparatedByString:@" "];
		NSMutableArray* sequence = [[NSMutableArray alloc] init];
		for (NSString* string in strSequenceArray) {
			[sequence addObject:[[NSNumber alloc] initWithInt:validateInt(@"Sequence value wrong", string)]];
		}
		
		NSLog(@"%d, %d, %d", p, m, [sequence count]);
	}
	@catch (NSException * e) {
		NSRunAlertPanel([e name], [e reason], @"Ok", NULL, NULL);
	}
	@finally {
		
	}
}

@end
