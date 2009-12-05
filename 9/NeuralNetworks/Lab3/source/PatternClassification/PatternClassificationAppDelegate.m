//
//  PatternClassificationAppDelegate.m
//  PatternClassification
//
//  Created by Ivan Sidarau on 03.12.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import "PatternClassificationAppDelegate.h"

@implementation PatternClassificationAppDelegate

@synthesize window;

#define debug true

#ifdef debug
 #define PATTERNS_START 0 // from 0 to 9 
#define PATTERNS_END 1 // from 0 to 9

 #define PRED_PATTERNS @"/Users/rilley_elf/_dev/univer/9/NeuralNetworks/Lab3/source/patterns/patt__%d.txt"
 #define PRED_P2SOLVE @"/Users/rilley_elf/_dev/univer/9/NeuralNetworks/Lab3/source/patterns/patt__0.txt"
#endif

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification 
{
	imagePatterns = [[NSMutableArray alloc] init];
#ifdef debug
	for (int i = PATTERNS_START ; i <= PATTERNS_END ; i++)
		[self loadPatternFromFile:
		 [NSString stringWithFormat:PRED_PATTERNS,i]
		 ];
#endif
}
-(void)loadPatternFromFile:(NSString*)fileName
{
	ImagePattern* pattern = [[ImagePattern alloc] initPairFromFile:fileName];
	if (pattern)
	{
		[imagePatterns addObject:pattern];
		[patternNames insertText:fileName];
		[patternNames insertText:@"\n"];
	}
	else
		NSRunAlertPanel(@"Cant add next pattern. File incorrect", fileName, @"Ok", NULL, NULL);
}
-(IBAction)openPattern:(id)sender
{
	NSOpenPanel* openPanel = [NSOpenPanel openPanel];
	[openPanel setAllowsMultipleSelection:YES];
	NSArray* types  = [[NSArray alloc] initWithObjects:@"txt", nil];
	if ( [openPanel runModalForTypes: types] == NSOKButton )
		for (NSString* fileName in [openPanel filenames]) 
			[self loadPatternFromFile:fileName];
	[types release];
}
-(IBAction)sendPattern:(id)sender
{
#ifdef debug
	[self findAssotiation:
	 PRED_P2SOLVE];
	return;
#endif
	NSOpenPanel* openPanel = [NSOpenPanel openPanel];
	NSArray* types  = [[NSArray alloc] initWithObjects:@"txt", nil];
	if ( [openPanel runModalForTypes: types] == NSOKButton )
		[self findAssotiation:[openPanel filename]];
	[types release];	
}

-(void) generateW
{
	w = malloc(sizeof(int)*a_size*b_size);
	for (int i = 0 ; i < a_size ; i++)
		for (int u = 0 ; u < b_size ; u++)
			w[ b_size*i + u ] = 0;
	for (ImagePattern* p in imagePatterns)
		for (int i = 0 ; i < a_size ; i++)
			for (int u = 0 ; u < b_size ; u++)
				w[ b_size*i + u] += obfruscator([[p.a objectAtIndex:i] intValue])*obfruscator([[p.b objectAtIndex:u] intValue]);
	
}
-(void) setCurrentPattern:(ImagePattern*)pattern
{
	if ([pattern.a count] == a_size)
		current_size = a_size;
	else
		current_size = b_size;
	current = malloc(sizeof(int)*current_size);
	for (int i = 0 ; i < current_size ; i++)
		current[i] = obfruscator([[pattern.a objectAtIndex:i] intValue]);	
}
-(void) printCurrentPattern
{
	for (int i = 0 ; i < current_size ; i++)
		[patternNames insertText:[NSString stringWithFormat:@"%d ",minimizator( current[i] )]];
	[patternNames insertText:[NSString stringWithFormat:@"\t%d \n",currentE]];	
}

-(void)findAssotiation:(NSString*)fileName
{
	if ([imagePatterns count] == 0)
	{
		NSRunAlertPanel(@"Load at least one pattern pair, using command+o", @"", @"Ok", NULL, NULL);
		return;
	}
	ImagePattern* pattern = [[ImagePattern alloc] initSearchFromFile:fileName];
	if (pattern)
	{
		ImagePattern* zero = [imagePatterns objectAtIndex:0];
		a_size = [zero.a count];
		b_size = [zero.b count];
		for (ImagePattern* p in imagePatterns) 
			if ([p.a count] != a_size || [p.b count] != b_size)
			{
				NSRunAlertPanel(@"This patterns pairs have different size, please restart program", @"", @"Ok", NULL, NULL);
				[pattern release];
				return;
			}
		if ([pattern.a count] != a_size && [pattern.a count] != b_size)
		{
			NSRunAlertPanel(@"Incoming pattern has different size, try another one", @"", @"Ok", NULL, NULL);
			[pattern release];
			return;
		}

		[self generateW];
		[self setCurrentPattern:pattern];
		
		[self getAssociation];
		for (int cycle_index = 1; cycle_index < 12 ; cycle_index++) // TODO: create real while cycle
		{
			[self getAssociation];
			[self getAssociation];			
			[self printCurrentPattern];
		}
		free(current);
		[pattern release];
		free(w);
	}
	else
		NSRunAlertPanel(@"This pattern we can't use to find associtation", fileName, @"Ok", NULL, NULL);
}

-(void) getAssociation;
{
	int* r;
	int r_size;
	currentE = 0;
	if (current_size == a_size) // current (Xk) have a, r (Yk) have b, W have a,b
	{
		r_size = b_size;
		r = malloc(sizeof(int)*b_size);
		for (int i = 0 ; i < b_size ; i++ )
			r[i] = 0;
		for (int i = 0 ; i < a_size ; i++)
			for (int u = 0 ; u < b_size ; u++)
				r[u] += w[b_size*i +u]*current[i];
		for (int i = 0 ; i < a_size; i++)
			for (int u = 0 ; u < b_size ; u++)
				currentE -= current[i]*w[b_size*i +u]*r[u];
	}
	else  // current (Xk) have b, r (Yk) have a, W have a,b
	{
		r_size = a_size;
		r = malloc(sizeof(int)*a_size);
		for (int i = 0 ; i < a_size ; i++ )
			r[i] = 0;
		for (int i = 0 ; i < a_size ; i++)
			for (int u = 0 ; u < b_size ; u++)
				r[i] += w[b_size*i +u]*current[u];
		for (int i = 0 ; i < a_size; i++)
			for (int u = 0 ; u < b_size ; u++)
				currentE -= current[u]*w[b_size*i +u]*r[i];
				
	}
	free( current );
	current = r;
	current_size = r_size;
	[self signCurrent];
}

-(void) signCurrent
{
	for(int i = 0 ; i < current_size ; i++)
		current[i] = sign( current[i] );
}

@end

int sign(int i)
{
//	return i;
	if (i == 0)
		return 0;
	return i/abs(i);
}

int obfruscator(int i)
{
	if (i == 1)
		return 1;
	return -1;	
}
int minimizator(int i)
{
	if (i > 0)
		return 1;
	else
		return 0;
}
