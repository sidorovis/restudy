//
//  ImageBlockIterator.m
//  NeuroArchivator
//
//  Created by Ivan Sidarau on 11.09.09.
//  Copyright 2009 rilley_elf corp. All rights reserved.
//

#import "ImageBlockIterator.h"
#import "ImageAlgorythms.h"

@implementation ImageBlockIterator
-(ImageBlockIterator*) initWithImage:(NSImage*)image_ n:(int)n_ m:(int)m_
{
	width = n_;
	height = m_;
	imageRep = [[NSBitmapImageRep imageRepWithData:[image_ TIFFRepresentation]] copy];
	[ ImageAlgorythms getImageSize:image_ h:&imageHeight w:&imageWidth l:&imageLayersCount ];
	if ( imageWidth < width || imageHeight < height )
		return NULL;
	startX = startY = 0;
	return self;
}
-(ImageBlockIterator*)initWithHeight:(int)height_ Width:(int)width_ N:(int)n_ M:(int)m_;
{
	imageHeight = height_;
	imageWidth = width_;
	height = m_;
	width = n_;
	startX = startY = 0;
	imageRep = NULL;
	return self;
}

-(void) dealloc
{
	if (imageRep)
		[imageRep release];
	[super dealloc];
}
-(ImageBlockIterator*)getNextWithAutoRelease:(BOOL)autoRelease;
{
	startX += width;
	if (startX >= imageWidth)
	{
		startX = 0;
		startY += height;
		if (startY == imageHeight);
		else
		if (startY + height > imageHeight)
			startY = imageHeight - height;
	}	
	if (startX + width > imageWidth)
		startX = imageWidth - width;
	if (startY >= imageHeight)
	{
		if (autoRelease == YES)
			[self release];
		return NULL;
	}
	return self;
}
-(NSBitmapImageRep*) imageRep {	return imageRep; }
-(void) getRed { colorVal = [color redComponent]; }
-(void) getBlue { colorVal = [color blueComponent]; }
-(void) getGreen { colorVal = [color greenComponent]; }
-(float*) getX0Vector:(SEL)selector
{
	float* answer = malloc( sizeof(float) * height * width );
	for (int u = startY ; u < startY + height ; u++)
		for (int i = startX ; i < startX + width ; i++)
		{
			color = [imageRep colorAtX:i y:u];
			[self methodForSelector:selector](self, selector);
			answer[ (u - startY) * width + (i - startX) ] = colorVal;
		}
	return answer;
}
-(void) getFastX0red:(float**)vectorX0Red green:(float**)vectorX0Green blue:(float**)vectorX0Blue
{
	(*vectorX0Red) = malloc( sizeof(float) * height * width);
	(*vectorX0Green) = malloc( sizeof(float) * height * width);
	(*vectorX0Blue) = malloc( sizeof(float) * height * width);
	for (int u = startY ; u < startY + height ; u++)
		for (int i = startX ; i < startX + width ; i++)
		{
			color = [imageRep colorAtX:i y:u];
			(*vectorX0Red)[ (u - startY) * width + (i - startX) ] = [color redComponent];
			(*vectorX0Green)[ (u - startY) * width + (i - startX) ] = [color greenComponent];
			(*vectorX0Blue)[ (u - startY) * width + (i - startX) ] = [color blueComponent];
		}
}

-(void) setColorsToImageRep:(NSBitmapImageRep*)result data:(float**)resultColorsVector
// resultColorsVector[0] -> for red
// resultColorsVector[1] -> for green
// resultColorsVector[2] -> for blue
{
	for (int u = startY ; u < startY + height ; u++)
		for (int i = startX ; i < startX + width ; i++)
		{
			float r = resultColorsVector[0][ (u - startY) * width + (i - startX) ];
			float g = resultColorsVector[1][ (u - startY) * width + (i - startX) ];
			float b = resultColorsVector[2][ (u - startY) * width + (i - startX) ];
			
			NSColor* new = [NSColor colorWithDeviceRed:r
												 green:g
												  blue:b
												 alpha:alpha_level	];
			[result setColor:new atX:i y:u];
		}
}
@end
