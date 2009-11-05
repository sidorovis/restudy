//
//  SequenceDataController.h
//
//  Created by Ivan Sidarau on 22.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PredictorNeuroNet.h"

int validateInt(NSString* fieldName, NSString* stringValue)
{
	if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[1-9][0-9]*"] 
		 evaluateWithObject:stringValue] == YES)
		return [stringValue intValue];
	@throw [[NSException alloc] initWithName:@"Non validated parameters" reason:fieldName userInfo:NULL];
}
double validateDouble(NSString* fieldName, NSString* stringValue)
{
	if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[0-9]*\.[0-9]*"] 
		 evaluateWithObject:stringValue] == YES)
		return [stringValue doubleValue]/10.0;
	@throw [[NSException alloc] initWithName:@"Non validated parameters" reason:fieldName userInfo:NULL];
}

@interface SequenceDataController : NSViewController {
	IBOutlet NSTextField* sequenceField;
	IBOutlet NSTextField* P;
	IBOutlet NSTextField* M;
	IBOutlet NSTextField* Emin;
	double e_min;
	IBOutlet NSTextField* currentDiff;
	
	IBOutlet NSProgressIndicator* workIndicator;
	
	IBOutlet NSButton* generate;
	IBOutlet NSButton* start;
	IBOutlet NSButton* stop;

	NSThread* thread;
	PredictorNeuroNet* neuroNet;
}
+(void) init;
-(IBAction)predict:(id)sender;
-(IBAction)start:(id)sender;
-(IBAction)stop:(id)sender;
-(void) arch;
@end
