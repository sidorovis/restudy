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
-(void) dealloc
{
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
-(void) setColorsToImageRep:(NSBitmapImageRep*)result data:(float**)resultColorsVector
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
												 alpha:1	];
			[result setColor:new atX:i y:u];
		}
}
@end
