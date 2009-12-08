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

// #define debug true

#ifdef debug
 #define PATTERNS_START 0 // from 0 to 6
 #define PATTERNS_END 6 // from 0 to 6

 #define PRED_PATTERNS @"/Users/rilley_elf/_dev/univer/9/NeuralNetworks/Lab3/source/patterns/patt__%d.txt"
 #define PRED_P2SOLVE @"/Users/rilley_elf/_dev/univer/9/NeuralNetworks/Lab3/source/patterns/patt__2.txt"
#endif

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification 
{
	old = NULL;
	before = NULL;
	imagePatterns = [[NSMutableArray alloc] init];
#ifdef debug
	for (int i = PATTERNS_START ; i <= PATTERNS_END ; i++)
		[self loadPatternFromFile: [NSString stringWithFormat:PRED_PATTERNS,i]];
	[self sendPattern:NULL];
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
	[self findAssotiation:PRED_P2SOLVE];
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
			for (int u = 0 ; u < b_size ; u++) // obfruscator -> (0) -> -1, (1) -> 1
				w[ b_size*i + u] += obfruscator([[p.a objectAtIndex:i] intValue])*obfruscator([[p.b objectAtIndex:u] intValue]);
	return;
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
	return;
}
-(void) printCurrentPattern
{
	int enter_print;
	ImagePattern* zero = [imagePatterns objectAtIndex:0];
	if (current_size == a_size)
		enter_print = [zero.a_size_x intValue];
	else
		enter_print = [zero.b_size_x intValue];
	for (int i = 0 ; i < current_size ; i++)
	{
		[patternNames insertText:[NSString stringWithFormat:@"%d",minimizator( current[i] )]];
		if ((i+1) % enter_print == 0)
			[patternNames insertText:@"\n"];
	}
	[patternNames insertText:[NSString stringWithFormat:@"%d \n",currentE]];	
	return;
}

-(void)findAssotiation:(NSString*)fileName
{
#ifdef debug
	[patternNames insertText:PRED_P2SOLVE];
	[patternNames insertText:@"\n"];
#endif
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
		currentE = -100500;
		[self generateW];
		[self setCurrentPattern:pattern];
		
		[self printCurrentPattern];
		[self getAssociation];
		[self printCurrentPattern];
		int old_e = 42;
		int count = 0;
		while (old_e != currentE)
		{
			count += 1;
			old_e = currentE;
			[self getAssociation];
			[self printCurrentPattern];
			[self getAssociation];
			[self printCurrentPattern];
			[error setStringValue:[NSString stringWithFormat:@"%d",currentE]];
			[steps setStringValue:[NSString stringWithFormat:@"%d",count]];
		}
		free(current);
		[pattern release];
		free(w);
	}
	else
		NSRunAlertPanel(@"This pattern we can't use to find associtation", fileName, @"Ok", NULL, NULL);
	return;
}

-(void) getAssociation;
{
	int* r;
	int r_size;
	int cur_size, next_size;
	currentE = 0;
	if (current_size == a_size) // current (Xk) have a, r (Yk) have b, W have a,b
	{
		cur_size = a_size;
		next_size = b_size;
	}
	else  // current (Xk) have b, r (Yk) have a, W have a,b
	{
		cur_size = b_size;
		next_size = a_size;
	}
	
	r_size = next_size;
	r = malloc(sizeof(int)*next_size);
	for (int i = 0 ; i < next_size ; i++ )
		r[i] = 0;
	for (int i = 0 ; i < cur_size ; i++)
		for (int u = 0 ; u < next_size ; u++)
			r[u] += current[i] * [self getW4CurSize:cur_size i:i u:u];
		
	if (old)
		free( old );	
	old = before;
	before = current;
	current = r;
	current_size = r_size;

	if (old)
		signArray(current_size, current, old);
	else
		signArray(current_size, current, current);

	for (int i = 0 ; i < cur_size ; i++)
		for (int u = 0 ; u < next_size ; u++)
			currentE -= before[ i ]*[self getW4CurSize:cur_size i:i u:u]*current[ u ];

	return;
}
-(int) getW4CurSize:(int)cur_size i:(int)i u:(int)u
{
	if (cur_size == a_size)
		return w[b_size*i + u];
	else
		return w[b_size*u + i];
}

-(void) printW
{
	NSLog(@"TODO");
}


@end

void signArray(int size, int array[], int old_array[])
{
	for(int i = 0 ; i < size ; i++)
		array[i] = sign( array[i], old_array[i] );
	return;
}

int sign(int i,int old_value)
{
//	return i;
	if (i == 0)
		return old_value;
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
