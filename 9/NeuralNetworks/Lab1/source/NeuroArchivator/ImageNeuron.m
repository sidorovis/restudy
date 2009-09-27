//
//  ImageNeuron.m
//  NeuroArchivator
//
//  Created by Ivan Sidarau on 16.09.09.
//  Copyright 2009 rilley_elf corp. All rights reserved.
//

#import "ImageNeuron.h"


@implementation ImageNeuron
-(ImageNeuron*) initWithIndex:(int)index_ length:(int)length_
{
	[super initWithWLength:length_];
	index = index_;
	return self;
}
@synthesize index;

-(ImageNeuron*) copy
{
	ImageNeuron* new = [[ImageNeuron alloc] init];
	new.index = index;
	new.vectorW = malloc( sizeof(float) * length);
	for (int i = 0 ; i < length ; i++)
		new.vectorW[i] = vectorW[i];
	return new;
}
-(NSString*)description
{
	NSString* res = @"";
	for (int i = 0 ; i < length ; i++)
	{
		float f = vectorW[i];
		res = [res stringByAppendingFormat:@"%f ", f];
	}
	res = [res stringByAppendingString:@"\n"];
	return res;
}
@end
