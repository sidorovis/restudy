//
//  ImageBlockIterator.h
//  NeuroArchivator
//
//  Created by Ivan Sidarau on 11.09.09.
//  Copyright 2009 rilley_elf corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define alpha_level 1

@interface ImageBlockIterator : NSObject 
{
	NSBitmapImageRep* imageRep;	
	int imageHeight, imageWidth, imageLayersCount;
	int height, width;
	int startX, startY;
	double colorVal;
	NSColor* color;
}
-(ImageBlockIterator*)initWithImage:(NSImage*)image_ n:(int)n_ m:(int)m_;
-(ImageBlockIterator*)initWithHeight:(int)height_ Width:(int)width_ N:(int)n_ M:(int)m_;
-(void) dealloc;
-(ImageBlockIterator*)getNextWithAutoRelease:(BOOL)autoRelease;
-(NSBitmapImageRep*) imageRep;
-(double*) getX0Vector:(SEL)selector;
-(void) getFastX0red:(double**)vectorX0Red green:(double**)vectorX0Green blue:(double**)vectorX0Blue;
-(void) getRed;
-(void) getBlue;
-(void) getGreen;
-(void) setColorsToImageRep:(NSBitmapImageRep*)result data:(double**)resultColorsVector;
@end
