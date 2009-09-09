#import "ImageController.h"

@implementation ImageController
- (IBAction)loadSourceImage:(id)sender 
{
    NSOpenPanel* openPanel = [NSOpenPanel openPanel];
	[openPanel setCanChooseFiles:YES];
	[openPanel setCanCreateDirectories:NO];
	[openPanel setCanCreateDirectories:NO];
	[openPanel setCanSelectHiddenExtension:NO];
	[openPanel setAllowsMultipleSelection:NO];
	[openPanel setAllowsOtherFileTypes:NO];
	if ( [openPanel runModalForTypes:[[NSArray alloc] initWithObjects:@"jpg", @"tiff", @"png", nil]] == NSOKButton )
	{
		[sourceImage setImage:[[NSImage alloc] initWithContentsOfFile:[openPanel filename] ] ];
		[archiveButton setEnabled:YES];
		[openSourceImageControl setEnabled:NO];
		[openArchiveMatrixControl setEnabled:YES];
		[closeControl setEnabled:YES];
		[n setEnabled:YES];
		[m setEnabled:YES];
		[p setEnabled:YES];
		[a setEnabled:YES];
	}
}

- (IBAction)loadArchiveMatrix:(id)sender
{
	{
		[openArchiveMatrixControl setEnabled:NO];
		[archiveButton setEnabled:NO];
		[deArchiveButton setEnabled:YES];
		[saveArchiveMatrixControl setEnabled:YES];
	}
}

- (IBAction)saveResultImage:(id)sender 
{
    
}

- (IBAction)saveArchiveMatrix:(id)sender
{
}

+ (void)testOnInt:(NSString*)value errorStr:(NSString**)answer errorStrV:(NSString*)err result:(int*)result
{
	if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[1-9][0-9]*"] evaluateWithObject:value] == YES)
		*result = [value intValue];
	else
		*answer = [*answer stringByAppendingString:err];	
}
- (void) createW0Matrix
{
	if (w)
		[w release];
	w = [[NSMutableArray alloc] init];
	for (int i = 0 ; i < i_n ; i++)
		for (int u = 0 ; u < i_m ; u++)
		{
			NSMutableArray* new_row = [[NSMutableArray alloc] init];
			for (int y = 0 ; y < i_p ; y++)
				[new_row addObject:[[NSNumber alloc] initWithFloat:(((rand()%2)?1.0:1.0)*1.0*(rand()%RANDOM_MULTIMIZATOR)/RANDOM_MULTIMIZATOR)] ];
			[w addObject:new_row];
		}
}
- (void) printW0Matrix
{
	NSString* str = [[NSString alloc] initWithFormat:@"%d %d\n", i_n, i_m];
	for (int i = 0 ; i < i_n ; i++)
		for (int u = 0 ; u < i_m ; u++)
		{
			NSMutableArray* arr = [w objectAtIndex:(i*(i_m)+u)];
			for (int y = 0 ; y < i_p ; y++)
				str = [str stringByAppendingString:[[NSString alloc] initWithFormat:@"%.2f ", [[arr objectAtIndex:y] floatValue]]];
			str = [str stringByAppendingString:@"\n"];
		}
	[table setString:str];
}
+ (void) getImageSize:(NSImage*)image h:(int*)hs w:(int*)ws l:(int*)ls
{
	NSBitmapImageRep* sourceRep = [NSBitmapImageRep imageRepWithData:[image TIFFRepresentation]];	
	*hs = [sourceRep pixelsHigh];
	*ws = [sourceRep pixelsWide];
	*ls = [sourceRep samplesPerPixel];
}
+ (float) compareImage:(NSImage*)left withImage:(NSImage*)right
{
	return [ImageController comparePartOfImage:left withImage:right x_s:0 y_s:0 x_f:(int)[left size].height-1 y_f:(int)[left size].width-1];
}
+ (float) comparePartOfImage:(NSImage*)left withImage:(NSImage*)right x_s:(int)x_s y_s:(int)y_s x_f:(int)x_f y_f:(int)y_f
{
	NSBitmapImageRep* leftRep = [NSBitmapImageRep imageRepWithData:[left TIFFRepresentation]];	
	NSBitmapImageRep* rightRep = [NSBitmapImageRep imageRepWithData:[right TIFFRepresentation]];	
	
	int l_h,l_w,l_l;
	int r_h,r_w,r_l;
	[ImageController getImageSize:left h:&l_h w:&l_w l:&l_l];
	[ImageController getImageSize:right h:&r_h w:&r_w l:&r_l];
	if (l_h != r_h || l_w != r_w || l_l != r_l || l_h == 0 || l_w == 0 || l_l == 0)
	{
		return 1.0;
	}
	if (
		x_s < 0 || x_s >= l_h ||
		y_s < 0 || y_s >= l_w ||
		x_f < 0 || x_f >= l_h ||
		y_f < 0 || y_f >= l_w
		)
		return 1.0;
	float diff = 0.0;
	for (int x = x_s ; x < x_f ; x++)
		for (int y = y_s ; y < y_f ; y++)
		{
			NSColor *leftColor = [leftRep colorAtX:x y:y];
			NSColor *rightColor = [rightRep colorAtX:x y:y];
			diff += fabs([leftColor redComponent] - [rightColor redComponent]);
			diff += fabs([leftColor greenComponent] - [rightColor greenComponent]);
			diff += fabs([leftColor blueComponent] - [rightColor blueComponent]);
		}
	return diff / (float)l_h / (float)l_w / (float)l_l;
}
- (IBAction)archive:(id)sender 
{
	NSString* variables = @"";
	[ImageController testOnInt:[n stringValue] errorStr:&variables errorStrV:@"n " result:&i_n];
	[ImageController testOnInt:[m stringValue] errorStr:&variables errorStrV:@"m " result:&i_m];
	[ImageController testOnInt:[p stringValue] errorStr:&variables errorStrV:@"p " result:&i_p];
	if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"(0)(\\.)[0-9]*[1-9]"] evaluateWithObject:[a stringValue]] == YES)
		i_a = [[a stringValue] floatValue ];
	else
		variables = [variables stringByAppendingString:@"a "];	
	
	if (variables != @"")
	{
		NSRunAlertPanel(@"Warning", [@"Wrong input on " stringByAppendingString:variables], @"Ok", nil, nil);
		return;
	}
	[self createW0Matrix];
	[self printW0Matrix];

	NSImage* source = [sourceImage image];
	int i_h, i_w, i_l;
	[ImageController getImageSize:source h:&i_h w:&i_w l:&i_l];
	if ( i_l != 3 )
	{
		NSRunAlertPanel(@"Warning", @"Please choose image with 3-color RGB.", @"Ok", nil, nil);
		return;
	}
	NSImage* im = [source copy];
//	NSBitmapImageRep* leftRep = [NSBitmapImageRep imageRepWithData:[im TIFFRepresentation]];
//	NSColor* c = [leftRep colorAtX:300 y:300 ];
//	[leftRep setColor:c atX:0 y:0];
//	NSImage* nn = [[NSImage alloc] initWithData:[leftRep TIFFRepresentation]];

	float res = [ImageController compareImage:source withImage:source];
	
	NSString* t = [[NSString alloc] initWithFormat:@"%d %d %d %f", i_h, i_w, i_l, res];
	NSRunAlertPanel(@"Warning", t , @"Ok", nil, nil);
	
}

- (IBAction)deArchive:(id)sender 
{
    
}

- (IBAction)close:(id)sender 
{
	if (w)
		[w release];
	if ([sourceImage image])
	{
		NSImage* image = [sourceImage image];
		[sourceImage setImage:nil];
		[image release];
	}
	if ([resultImage image])
	{
		NSImage* image = [resultImage image];
		[resultImage setImage:nil];
		[image release];
	}
	[openSourceImageControl setEnabled:YES];
	[openArchiveMatrixControl setEnabled:NO];
	[saveResultImageControl setEnabled:NO];
	[saveArchiveMatrixControl setEnabled:NO];
	[archiveButton setEnabled:NO];
	[deArchiveButton setEnabled:NO];
	[closeControl setEnabled:NO];
}
@end
