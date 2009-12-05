//
//  PatternClassificationAppDelegate.h
//  PatternClassification
//
//  Created by Ivan Sidarau on 03.12.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ImagePattern.h"

int obfruscator(int);
int minimizator(int);
int sign(int);

@interface PatternClassificationAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	NSMutableArray* imagePatterns;
	int* w;
	int* current;
	int current_size;
	int currentE;
	int a_size, b_size;
	IBOutlet NSTextView* patternNames;
}
-(void)loadPatternFromFile:(NSString*)fileName;
@property (assign) IBOutlet NSWindow *window;
-(IBAction)openPattern:(id)sender;
-(IBAction)sendPattern:(id)sender;
-(void)findAssotiation:(NSString*)fileName;
-(void) getAssociation;
-(void) signCurrent;
-(void) generateW;
-(void) setCurrentPattern;
-(void) printCurrentPattern:(ImagePattern*)pattern;
@end
