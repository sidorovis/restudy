//
//  NeuroNet.m
//  NeuroArchivator
//
//  Created by Ivan Sidarau on 10.09.09.
//  Copyright 2009 rilley_elf corp. All rights reserved.
//

#import "NeuroNet.h"
#import "ImageAlgorythms.h"

@implementation NeuroNet
- (void) dealloc
{
	for (int i = 0 ; i < layCount ; i++)
		[lays[i] release];
	free( lays );	
	[super dealloc];
}
- (BOOL) goodEnough
{
	return YES;
}
- (void) teach
{
		return;
}
/*- (void) saveState
{
	NSLog(@"saveState was not created for NeuroNet");
}
- (void) loadState
{
	NSLog(@"loadState was not created for NeuroNet");
}
 */
@end
