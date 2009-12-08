//
//  Pattern.m
//  PatternClassification
//
//  Created by Ivan Sidarau on 03.12.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import "ImagePattern.h"


@implementation ImagePattern

@synthesize a;
@synthesize b;
@synthesize a_size_x;
@synthesize b_size_x;

-(int) readImage:(NSMutableArray*)image lines:(NSArray*)lines from:(int)i
{
	if (i == -1) return -1;
	while (i < [lines count] && [[lines objectAtIndex:i] isEqualToString:@""]) i++;
	NSString* str;
	temp = [[lines objectAtIndex:i] length];
	for(; i < [lines count] && ![ (str = [lines objectAtIndex:i]) isEqualToString:@""] ; i++)
		for (int u = 0 ; u < [str length] ; u++)
		{
			char c = [str characterAtIndex:u];
			if (c < '0' || c > '9')
				return -1;
			[image addObject:[[NSNumber alloc] initWithChar:(c - '0')]];			
		}
	return i;
}
-(ImagePattern*)initSearchFromFile:(NSString*)fileName
{
	self = [super init];
	NSString* str = [[NSString alloc] initWithContentsOfFile:fileName];
	NSArray* lines = [str componentsSeparatedByString:@"\n"];
	a = [[NSMutableArray alloc] init];
	b_size_x = NULL;
	if ([self readImage:a lines:lines from:0] != -1)
	{
		a_size_x = [[NSNumber alloc] initWithInt:temp];
//		NSLog(fileName);
//		NSLog(@"%@", a_size_x);
		b = NULL;
		return self;		
	}
	[a release];
	[lines release];
	[str release];
	[self release];
	return NULL;
}
-(ImagePattern*)initPairFromFile:(NSString*)fileName
{
	self = [super init];
	NSString* str = [[NSString alloc] initWithContentsOfFile:fileName];
	NSArray* lines = [str componentsSeparatedByString:@"\n"];
	a = [[NSMutableArray alloc] init];
	b = [[NSMutableArray alloc] init];
	int res;
	if ((res = [self readImage:a lines:lines from:0]) == -1)
	{
		[str release];
		[lines release];
		[b release];
		[a release];
		[self release];
		return NULL;		
	}
	else
	{
		a_size_x = [[NSNumber alloc] initWithInt:temp];
		if (([self readImage:b lines:lines from:res]) == -1)
		{
			[str release];
			[lines release];
			[b release];
			[a release];
			[self release];
			return NULL;		
		}
	}
	b_size_x = [[NSNumber alloc] initWithInt:temp];
	return self;
}
-(void) release
{
	[a release];
	[b release];
	[super release];
}

@end
