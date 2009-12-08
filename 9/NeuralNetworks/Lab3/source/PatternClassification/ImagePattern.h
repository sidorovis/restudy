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
	int temp;
	NSNumber* a_size_x, *b_size_x;
}
@property (readwrite,retain) NSMutableArray *a;
@property (readwrite,retain) NSMutableArray *b;
@property (readwrite,retain) NSNumber *a_size_x;
@property (readwrite,retain) NSNumber *b_size_x;

-(ImagePattern*)initPairFromFile:(NSString*)fileName;
-(ImagePattern*)initSearchFromFile:(NSString*)fileName;
-(void) release;
-(int) readImage:(NSMutableArray*)image lines:(NSArray*)lines from:(int)i;
@end
