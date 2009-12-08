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
void signArray(int size, int array[]);

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
-(void) generateW;
-(void) printCurrentPattern;
-(void) printW;
-(int) getW4CurSize:(int)cur_size i:(int)i u:(int)u;
-(void) setCurrentPattern:(ImagePattern*)pattern;
@end
