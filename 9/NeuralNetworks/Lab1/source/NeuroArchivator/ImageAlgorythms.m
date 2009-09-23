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
	NSScanner* scanner;
	NSBitmapImageRep* imageRep;
	@try {
		scanner = [[NSScanner alloc] initWithString:stringRep];
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
		imageRep = 
			[[NSBitmapImageRep alloc] 
						initWithBitmapDataPlanes:NULL 
						pixelsWide:width 
						pixelsHigh:height 
						bitsPerSample:8 
						samplesPerPixel:4 
						hasAlpha:YES 
						isPlanar:NO 
						colorSpaceName:NSCalibratedRGBColorSpace 
						bitmapFormat:NSAlphaFirstBitmapFormat 
						bytesPerRow:4*width 
						bitsPerPixel:32];
		float* vectorY = malloc( sizeof(float) * p);
		float** vectorX1 = malloc( sizeof(float*) * colorSize);
		for (int i = 0 ; i < colorSize ; i++)
			vectorX1[i] = malloc( sizeof( float) * n*m);
		do
		{
			for (int colorIndex = 0 ; colorIndex < colorSize ; colorIndex++)
			{
				for (int i = 0 ; i < p ; i++)
					[scanner scanFloat:(&vectorY[i])];
				for (int i = 0 ; i < n*m ; i++)
					vectorX1[colorIndex][i] = 0;
				for (int i = 0 ; i < p ; i++)
					for (int u = 0 ; u < n*m ; u++)
						vectorX1[colorIndex][u] += w[i][u] * vectorY[i];
			}
			[iterator setColorsToImageRep:imageRep data:vectorX1];
		} 
		while( [iterator getNextWithAutoRelease:YES] );
		for (int i = 0 ; i < colorSize ; i++)
			free (vectorX1[i]);
		free( vectorX1 );
		free( vectorY );
		for (int i = 0 ; i < p ; i++)
			free( w[i]);
		free( w );
		result = [[NSImage alloc] initWithData:[ imageRep TIFFRepresentation ]];
		
	}
	@catch (NSException * e) {
		NSRunAlertPanel(@"Warning", 
						[@"Error while parsing archive:" stringByAppendingString:[e name]], 
						@"Ok", nil, nil);
	}
	@finally {
		[imageRep release];
		[scanner release];
		return result;
	}
	return result;
}
@end
