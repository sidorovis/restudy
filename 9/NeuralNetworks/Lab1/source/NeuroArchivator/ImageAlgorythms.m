//
//  ImageAlgorythms.m
//  NeuroArchivator
//
//  Created by Ivan Sidarau on 10.09.09.
//  Copyright 2009 rilley_elf corp. All rights reserved.
//

#import "ImageAlgorythms.h"

@implementation ImageAlgorythms

+ (void) getImageSize:(NSImage*)image h:(int*)hs w:(int*)ws l:(int*)ls
{
	NSBitmapImageRep* sourceRep = [NSBitmapImageRep imageRepWithData:[image TIFFRepresentation]];	
	*hs = [sourceRep pixelsHigh];
	*ws = [sourceRep pixelsWide];
	*ls = [sourceRep samplesPerPixel];
}
+ (BOOL) validateImageOnRGB:( NSImage*)image
{
	int i_h, i_w, i_l;
	[ImageAlgorythms getImageSize:image h:&i_h w:&i_w l:&i_l];
	if ( i_l != colorSize )
	{
		NSRunAlertPanel(@"Warning", @"Please choose image with 3-color RGB.", @"Ok", nil, nil);
		return NO;
	}
	return YES;
}
 
@end
