//
//  Pattern.h
//  PatternClassification
//
//  Created by Ivan Sidarau on 03.12.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ImagePattern : NSObject {
	NSMutableArray *a, *b;
}
@property (readwrite,retain) NSMutableArray *a;
@property (readwrite,retain) NSMutableArray *b;

-(ImagePattern*)initPairFromFile:(NSString*)fileName;
-(ImagePattern*)initSearchFromFile:(NSString*)fileName;
-(void) release;
-(int) readImage:(NSMutableArray*)image lines:(NSArray*)lines from:(int)i;
@end
