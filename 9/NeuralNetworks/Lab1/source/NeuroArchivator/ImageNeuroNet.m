//
//  ImageNeuroNet.m
//  NeuroArchivator
//
//  Created by Ivan Sidarau on 16.09.09.
//  Copyright 2009 rilley_elf corp. All rights reserved.
//

#import "ImageNeuroNet.h"


@implementation ImageNeuroNet
+ (void)testOnInt:(NSString*)value errorStr:(NSString**)answer errorStrV:(NSString*)err result:(int*)result
{
	NSString* matches = @"SELF MATCHES %@";
	NSString* regexp = @"[1-9][0-9]*";
	if ([[NSPredicate predicateWithFormat:matches, regexp] evaluateWithObject:value] == YES)
		*result = [value intValue];
	else
		*answer = [*answer stringByAppendingString:err];
	[regexp release];
	[matches release];
}
+ (BOOL) validateParams:(NSString*)n_ m:(NSString*)m_ p:(NSString*)p_ a:(NSString*)a_ d:(NSString*)d_ n_i:(int*)n m_i:(int*)m p_i:(int*)p a_f:(float*)a d_i:(int*)d;
{
	NSString* variables = @"";
	[ImageNeuroNet testOnInt:n_ errorStr:&variables errorStrV:@"n " result:n];
	[ImageNeuroNet testOnInt:m_ errorStr:&variables errorStrV:@"m " result:m];
	[ImageNeuroNet testOnInt:p_ errorStr:&variables errorStrV:@"p " result:p];
	[ImageNeuroNet testOnInt:d_ errorStr:&variables errorStrV:@"d " result:d];
	if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"(0)(\\.)[0-9]*[1-9]"] evaluateWithObject:a_] == YES)
		*a = [a_ floatValue ];
	else
		variables = [variables stringByAppendingString:@"a "];	
	
	if (variables != @"")
	{
		NSRunAlertPanel(@"Warning", [@"Wrong input on " stringByAppendingString:variables], @"Ok", nil, nil);
		return NO;
	}
	return YES;
}

// alloc
+ (ImageNeuroNet*) tryInit:(NSImage*)image_ nStr:(NSString*)nStr mStr:(NSString*)mStr pStr:(NSString*)pStr aStr:(NSString*)aStr dStr:(NSString*)dStr
{
	if ([ImageAlgorythms validateImageOnRGB:image_] == NO)
		return NULL;
	int n, m, p, d;
	float a;
	if ([ImageNeuroNet validateParams:nStr m:mStr p:pStr a:aStr d:dStr n_i:&n m_i:&m p_i:&p a_f:&a d_i:&d] == NO)
		return NULL;
	return [[ImageNeuroNet alloc] initWithImage:image_ width:n height:m neuronCountOn1:p a:a d:d];
}
- (ImageNeuroNet*) initWithImage:(NSImage*)image_ width:(int)width_ height:(int)height_ neuronCountOn1:(int)neuronCountOn1_ a:(float)teachK_ d:(int)enoughK_
{
	image = image_;
	width = width_;
	height = height_;
	teachK = teachK_;
	enoughK = enoughK_;
	layCount = layers_count;
	lays = malloc( sizeof(ImageNeuronLay*) * layers_count);
	lays[0] = [[ImageNeuronLay alloc] initWithCount:(width*height) nextLayCount:neuronCountOn1_];
	lays[1] = [[ImageNeuronLay alloc] initWithCount:neuronCountOn1_ nextLayCount:(width*height)];
	saveDiff = 9999999999;
	saveLays = NULL;
	colorSelectorCount = colorSize;
	colorSelectors = malloc( sizeof(SEL) * colorSize );
	colorSelectors[0] = @selector( getRed );
	colorSelectors[1] = @selector( getGreen );
	colorSelectors[2] = @selector( getBlue );
	return self;
}

- (void) dealloc
{
	free( colorSelectors );
	if (saveLays)
	{
		for (int i = 0 ; i < layCount ; i++)
			[(ImageNeuronLay*)saveLays[i] release];
		free( saveLays );
		saveLays = NULL;
	}	
	[super dealloc];
}

- (BOOL) goodEnough
{
	float diff = 0;
	ImageBlockIterator* iterator = [[ImageBlockIterator alloc] initWithImage:image n:width m:height];

	do
	{
		for (int i = 0 ; i < colorSelectorCount ; i++)
		{
			float* vectorX0 = [iterator getX0Vector:colorSelectors[ 0 ]];
			float* vectorY = [(ImageNeuronLay*)lays[0] getAnswerOnSignal:vectorX0];
			float* vectorX1 = [(ImageNeuronLay*)lays[1] getAnswerOnSignal:vectorY]; 
			diff += getDiff(width*height, vectorX0, vectorX1);
			free( vectorX1 );
			free( vectorY );
			free( vectorX0 );
		}
	}
	while( [iterator getNextWithAutoRelease:YES] );
	if (saveDiff > diff)
	{
		[self saveState];
		saveDiff = diff;
	}
	else 
	{
		[self loadState];
	}

	if (diff < enoughK)
		return YES;
	return NO;
}
- (BOOL) fastGoodEnough
{
	float diff = 0;
	ImageBlockIterator* iterator = [[ImageBlockIterator alloc] initWithImage:image n:width m:height];
	
	do
	{		
		float *vectorX0Red, *vectorX0Green, *vectorX0Blue, *vectorY;
		[iterator getFastX0red:&vectorX0Red green:&vectorX0Green blue:&vectorX0Blue];

		vectorY = [(ImageNeuronLay*)lays[0] getAnswerOnSignal:vectorX0Red];
		float* vectorX1Red = [(ImageNeuronLay*)lays[1] getAnswerOnSignal:vectorY];
		diff += getDiff(width*height, vectorX0Red, vectorX1Red);
		free( vectorX0Red );
		free( vectorY );
		free( vectorX1Red );
		
		vectorY = [(ImageNeuronLay*)lays[0] getAnswerOnSignal:vectorX0Green];
		float* vectorX1Green = [(ImageNeuronLay*)lays[1] getAnswerOnSignal:vectorY];
		diff += getDiff(width*height, vectorX0Green, vectorX1Green);
		free( vectorX0Green );
		free( vectorY );
		free( vectorX1Green );

		vectorY = [(ImageNeuronLay*)lays[0] getAnswerOnSignal:vectorX0Blue];
		float* vectorX1Blue = [(ImageNeuronLay*)lays[1] getAnswerOnSignal:vectorY];
		diff += getDiff(width*height, vectorX0Blue, vectorX1Blue);
		free( vectorX0Blue );
		free( vectorY );
		free( vectorX1Blue );
	}
	while( [iterator getNextWithAutoRelease:YES] );
	if (saveDiff > diff)
	{
		[self saveState];
		saveDiff = diff;
	}
	else 
	{
		[self loadState];
	}
	if (diff < enoughK)
		return YES;
	return NO;
}

- (void) teach
{
	ImageBlockIterator* iterator = [[ImageBlockIterator alloc] initWithImage:image n:width m:height];
	do
	{
		for (int i = 0 ; i < colorSelectorCount ; i++)
		{
			float diff = 0;
			float* vectorX0 = [iterator getX0Vector:colorSelectors[i]];
			float* vectorY = [(ImageNeuronLay*)lays[0] getAnswerOnSignal:vectorX0];
			float* vectorX1 = [(ImageNeuronLay*)lays[1] getAnswerOnSignal:vectorY];
			diff = getDiff(width*height, vectorX0, vectorX1);
			if (diff < enoughK)
			{
				// We should not teach first lay!
//				[(ImageNeuronLay*)lays[0] teachWithInSignal:vectorX0 OutSignal:vectorY ResultSignal:vectorX1 teachK:teachK];
				[(ImageNeuronLay*)lays[1] teachWithInSignal:vectorY OutSignal:vectorX1 InitSignal:vectorX0 teachK:teachK];
			}
			free( vectorX1 );
			free( vectorY );
			free( vectorX0 );
		}
	}
	while( [iterator getNextWithAutoRelease:YES] );
}
- (void) fastTeach
{
	ImageBlockIterator* iterator = [[ImageBlockIterator alloc] initWithImage:image n:width m:height];
	do
	{
		
		float diff = 0;
		float *vectorX0Red, *vectorX0Green, *vectorX0Blue, *vectorY;
		
		[iterator getFastX0red:&vectorX0Red green:&vectorX0Green blue:&vectorX0Blue];

		vectorY = [(ImageNeuronLay*)lays[0] getAnswerOnSignal:vectorX0Red];
		float* vectorX1Red = [(ImageNeuronLay*)lays[1] getAnswerOnSignal:vectorY];
		diff += getDiff(width*height, vectorX0Red, vectorX1Red);
		if (diff < enoughK)
			[(ImageNeuronLay*)lays[1] teachWithInSignal:vectorY OutSignal:vectorX1Red InitSignal:vectorX0Red teachK:teachK];
		diff = 0;
		free( vectorX0Red );
		free( vectorY );
		free( vectorX1Red );
		
		vectorY = [(ImageNeuronLay*)lays[0] getAnswerOnSignal:vectorX0Green];
		float* vectorX1Green = [(ImageNeuronLay*)lays[1] getAnswerOnSignal:vectorY];
		diff += getDiff(width*height, vectorX0Green, vectorX1Green);
		if (diff < enoughK)
			[(ImageNeuronLay*)lays[1] teachWithInSignal:vectorY OutSignal:vectorX1Green InitSignal:vectorX0Green teachK:teachK];
		diff = 0;
		free( vectorX0Green );
		free( vectorY );
		free( vectorX1Green );
		
		vectorY = [(ImageNeuronLay*)lays[0] getAnswerOnSignal:vectorX0Blue];
		float* vectorX1Blue = [(ImageNeuronLay*)lays[1] getAnswerOnSignal:vectorY];
		diff += getDiff(width*height, vectorX0Blue, vectorX1Blue);
		if (diff < enoughK)
			[(ImageNeuronLay*)lays[1] teachWithInSignal:vectorY OutSignal:vectorX1Blue InitSignal:vectorX0Blue teachK:teachK];
		diff = 0;
		free( vectorX0Blue );
		free( vectorY );
		free( vectorX1Blue );
		
	}
	while( [iterator getNextWithAutoRelease:YES] );
	
}

- (void) saveState
{
	if (saveLays)
	{
		for (int i = 0 ; i < layCount ; i++)
			[(ImageNeuronLay*)saveLays[i] release];
		free( saveLays );
		saveLays = NULL;
	}
	saveLays = malloc( sizeof(ImageNeuronLay*) * layers_count );
	for (int i = 0 ; i < layCount ; i++)
		saveLays[i] = [(ImageNeuronLay*)lays[i] copy];
}
- (void) loadState
{
	if (saveLays == NULL)
		return;
	for (int i = 0 ; i < layCount ; i++)
	{
		[ (ImageNeuronLay*)lays[i] release ];
		lays[i] = saveLays[i];
	}
	free( saveLays );
	saveLays = NULL;
}

-(NSImage*) getResultImage
{
	NSBitmapImageRep* result = [NSBitmapImageRep imageRepWithData:[image TIFFRepresentation]];	

	ImageBlockIterator* iterator = [[ImageBlockIterator alloc] initWithImage:image n:width m:height];

	do
	{
		float** resultColorsVector = malloc( sizeof(float*) * colorSize );
		for (int i = 0 ; i < colorSelectorCount ; i++)
		{
			float* vectorX0 = [iterator getX0Vector:colorSelectors[i]];
			float* vectorY = [(ImageNeuronLay*)lays[0] getAnswerOnSignal:vectorX0];
			resultColorsVector[i] = [(ImageNeuronLay*)lays[1] getAnswerOnSignal:vectorY];
			free( vectorY );
			free( vectorX0 );
		}
		[iterator setColorsToImageRep:result data:resultColorsVector];
		for (int i = 0 ; i < colorSelectorCount ; i++)
			free( resultColorsVector[i] );
		free( resultColorsVector );
	}
	while( [iterator getNextWithAutoRelease:YES] );
	NSImage* answer = [[NSImage alloc] initWithData:[result TIFFRepresentation]];
	[result release];
	return answer;
}
-(NSString*)description
{
	int h,w,l;
	[ImageAlgorythms getImageSize:image h:&h w:&w l:&l];
	int p = [(ImageNeuronLay*)lays[0] nextLayCount ];
	
	NSString* res = 
		[[NSString alloc] initWithFormat:
			@"%d %d\n%d\n%d %d\n%@",
			width, height, p ,h, w,
			lays[1]
		 ];
	res = [res stringByAppendingString:@"\n"];
	ImageBlockIterator* iterator = [[ImageBlockIterator alloc] initWithImage:image n:width m:height];
	do
	{
		for (int i = 0 ; i < colorSelectorCount ; i++)
		{
			float* vectorX0 = [iterator getX0Vector:colorSelectors[i]];
			float* vectorY = [(ImageNeuronLay*)lays[0] getAnswerOnSignal:vectorX0];
			for (int u = 0 ; u < p ; u++)
				res = [res stringByAppendingFormat:@"%f ", vectorY[u]];
			free( vectorY );
			free( vectorX0 );			
		}
		res = [res stringByAppendingString:@"\n"];
	}
	while( [iterator getNextWithAutoRelease:YES] );
		
	return res;
}
@end
