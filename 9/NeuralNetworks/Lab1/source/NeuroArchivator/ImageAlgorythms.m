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
+(NSImage*) deArchive:(NSString*)stringRep
{
	NSImage* result = NULL;
	@try {
		NSScanner* scanner = [[NSScanner alloc] initWithString:stringRep];
		int n,m,p,height,width;
		[scanner scanInt:&n];
		[scanner scanInt:&m];
		[scanner scanInt:&p];
		[scanner scanInt:&height];
		[scanner scanInt:&width];
		float** w;
		w = malloc( sizeof( float* ) * p );
		for (int i = 0 ; i < p ; i++)
			w[i] = malloc( sizeof( float) * n * m );
		for (int i = 0 ; i < p ; i++)
			for (int u = 0 ; u < n*m ; u++)
				[scanner scanFloat:(&w[i][u])];
		ImageBlockIterator* iterator = [[ImageBlockIterator alloc] initWithHeight:height Width:width N:n M:m];
		NSBitmapImageRep* imageRep = [[NSBitmapImageRep alloc] initForIncrementalLoad];
		NSSize imageSize;
		imageSize.height = height;
		imageSize.width = width;
		[imageRep setSize:imageSize];
		do
		{
			
		} 
		while( [iterator getNextWithAutoRelease:YES] );
	}
	@catch (NSException * e) {
		NSRunAlertPanel(@"Warning", 
						[@"Error while parsing archive:" stringByAppendingString:[e name]], 
						@"Ok", nil, nil);
	}
	@finally {
		return result;
	}
	return result;
}
@end
