//
//  SequenceDataController.h
//
//  Created by Ivan Sidarau on 22.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DefaultBackErrorTeachingPredictorNeuroNet.h"
#import "ForwardStepTeachingPredictorNeroNet.h"

#define MAX_DOUBLE 999999999999

#define USE_DEFAULT_BACK_PROPAGATION_ALGORYTHM false


int validateInt(NSString* fieldName, NSString* stringValue)
{
	if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[1-9][0-9]*"] 
		 evaluateWithObject:stringValue] == YES)
		return [stringValue intValue];
	@throw [[NSException alloc] initWithName:@"Non validated parameters" reason:fieldName userInfo:NULL];
}
double validateDouble(NSString* fieldName, NSString* stringValue)
{
	if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"(\-)?[0-9]*\.[0-9]*"] 
		 evaluateWithObject:stringValue] == YES)
		return [stringValue doubleValue];
	@throw [[NSException alloc] initWithName:@"Non validated parameters" reason:fieldName userInfo:NULL];
}

double func_in( double input )
{
	return tanh( input / 100.0 );
}
double func_out( double input )
{
	return atanh( input ) * 100.0;
}

@interface SequenceDataController : NSViewController {
	IBOutlet NSTextField* sequenceField;
	NSMutableArray* sequence;
	IBOutlet NSTextField* P;
	IBOutlet NSTextField* M;
	int p, m;
	IBOutlet NSTextField* Emin;
	double e_min;
	IBOutlet NSTextField* currentDiff;
	IBOutlet NSTextView* resultView;
	
	IBOutlet NSProgressIndicator* workIndicator;
	
	IBOutlet NSButton* generate;
	IBOutlet NSButton* start;
	IBOutlet NSButton* stop;

	IBOutlet NSButton* getResultButton;

	NSThread* thread;
	NeuroNet* neuroNet;
}
+(void) init;
-(IBAction)predict:(id)sender;
-(IBAction)start:(id)sender;
-(IBAction)stop:(id)sender;
-(IBAction)getResults:(id)sender;
-(void) arch;
-(void) disableTextFields;
-(void) enableTextFields;
-(NeuroNet*) getNeuroNet;
@end
