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
	NSArray* types  = [[NSArray alloc] initWithObjects:@"jpg", @"tiff", @"png", nil];
	if ( [openPanel runModalForTypes: types] == NSOKButton )
	{
		[sourceImage setImage:[[NSImage alloc] initWithContentsOfFile:[openPanel filename] ] ];
		[openSourceImageControl setEnabled:NO];
		[openArchiveMatrixControl setEnabled:NO];
		[progress setUsesThreadedAnimation:YES];
		[self enableControls];
		withLogBool = [logWith state];
	}
	[types release];	
	neuroNet = NULL;
	resultImageInstance = NULL;
	archThreadPool = NULL;
	thread = NULL;
}
- (void) enableControls
{
	[teachZeroLayer setEnabled:YES];
	[adaptiveSteps setEnabled:YES];
	[n setEnabled:YES];	// n -> width
	[m setEnabled:YES]; // m -> height
	[p setEnabled:YES];
	[a setEnabled:YES];
	[D setEnabled:YES];
	[maxLoopsField setEnabled:YES];
	[closeControl setEnabled:YES];
	[archiveButton setEnabled:YES];
	[logWith setEnabled:YES];
	[normilizingWith setEnabled:YES];
	[logEachValue setEnabled:YES];
}
- (void) disableControls
{
	[teachZeroLayer setEnabled:NO];
	[adaptiveSteps setEnabled:NO];
	[n setEnabled:NO]; // n -> width
	[m setEnabled:NO]; // m -> height
	[p setEnabled:NO];
	[a setEnabled:NO];
	[D setEnabled:NO];
	[maxLoopsField setEnabled:NO];
	[closeControl setEnabled:NO];
	[archiveButton setEnabled:NO];	
	[logWith setEnabled:NO];
	[normilizingWith setEnabled:NO];
}
- (IBAction)loadArchiveMatrix:(id)sender
{
   NSOpenPanel* openPanel = [NSOpenPanel openPanel];
	[openPanel setCanChooseFiles:YES];
	[openPanel setCanCreateDirectories:NO];
	[openPanel setCanCreateDirectories:NO];
	[openPanel setCanSelectHiddenExtension:NO];
	[openPanel setAllowsMultipleSelection:NO];
	[openPanel setAllowsOtherFileTypes:NO];
	NSArray* types  = [[NSArray alloc] initWithObjects:@"", nil];
	if ( [openPanel runModalForTypes: types] == NSOKButton )
	{
		NSString* neuroNetStr = [[NSString alloc] initWithContentsOfFile:[openPanel filename]];
		NSImage* archivedImage = [ImageAlgorythms deArchive:neuroNetStr];
		if (!archivedImage)
		{
			NSRunAlertPanel(@"Error", @"Wrong image representation", @"Try again", nil, nil);
		}
		else 
		{
			[resultImage setImage:archivedImage];
			[archivedImage release];
			[openSourceImageControl setEnabled:NO];
			[openArchiveMatrixControl setEnabled:NO];
			[archiveButton setEnabled:NO];
			[saveArchiveMatrixControl setEnabled:NO];
			[closeControl setEnabled:YES];
 		}
	}
	[types release];
}

- (IBAction)saveArchiveMatrix:(id)sender
{
	NSSavePanel* savePanel = [NSSavePanel savePanel];
	[savePanel setCanCreateDirectories:YES];
	[savePanel setAllowsOtherFileTypes:NO];
	if ( [savePanel runModal] == NSOKButton )
	{
//		NSString* filename = [[savePanel filename] stringByAppendingString:@"" ];
//		NSString* neuroNetStrRepresentation = [[NSString alloc] initWithFormat:@"%@", neuroNet];
		NSLog(@"filesaving not supported in this version");
//		[ neuroNetStrRepresentation writeToFile:filename atomically:NO];
	}
}
- (void) neuro_arch
{
	archThreadPool = [[NSAutoreleasePool alloc] init];
	if (!neuroNet)
	{
		[archThreadPool release];
		return;
	}
	
	int loopCounter = 0;
	NSString* loops_error = @"";
	int maxLoops;
	[ImageNeuroNet testOnInt:[maxLoopsField stringValue] errorStr:&loops_error errorStrV:@"loop " result:&maxLoops];
	if (loops_error != @"")
	{
		NSRunAlertPanel(@"Warning", [@"Wrong input on " stringByAppendingString:loops_error], @"Ok", nil, nil);
		[archThreadPool release];
		return;
	}	
	
	[self disableControls];
	[closeControl setEnabled:FALSE];
	[archiveButton setEnabled:FALSE];
	[progress startAnimation:self];
	double old_diff = MAXFLOAT;
	int old_diff_eq_diff_marker = 0;
	double diff;
	double alpha;
	[neuroNet fastGoodEnough:&diff];
	if ([logWith state])
		NSLog(@",%d,%f", loopCounter, diff);
	@try 
	{
		while ([neuroNet fastGoodEnough:&diff] == NO)
		{
			if ( fabs(old_diff-diff) < MIN_DIFF_BETWEEN_DIFF)
			{
				old_diff_eq_diff_marker += 1 ;
				if (old_diff_eq_diff_marker > DIFF_EQUAL_MIN_TIMES)
				{
					NSRunAlertPanel(@"Note", @"We think that speed of archiving to slow.\nPlease 'Archive' to do next loop.", @"Ok", nil, nil);
					break;
				}
			}
			else 
			{
				old_diff_eq_diff_marker = 0;
				old_diff = diff;
			}
			[neuroNet fastTeach:&alpha];
			loopCounter++;
			if (loopCounter > maxLoops)
				break;
			[loopRes setStringValue:[NSString stringWithFormat:@"%d", loopCounter]];
			[currD setStringValue:[NSString stringWithFormat:@"%f", diff]];
			[currA setStringValue:[NSString stringWithFormat:@"%f", alpha]];
			if ([logWith state])
				if (loopCounter % ilogEachValue == 0)
					NSLog(@",%d,%f,%f", loopCounter, diff, alpha);
		}
		[neuroNet fastGoodEnough:&diff];
		if ([logWith state])
			NSLog(@",%d,%f,%f", loopCounter, diff);
		resultImageInstance = [neuroNet getResultImage];
		[resultImage setImage:resultImageInstance];
		[resultImageInstance release];
		resultImageInstance = NULL;		
	}
	@catch (NSException * e) 
	{
		NSRunAlertPanel(@"Warning",@"This network can't archive this image, please check 'With normilizing' to 'Yes'.", @"Ok", nil, nil);
		[neuroNet release];
		neuroNet = NULL;
	}
	@finally 
	{
		[saveArchiveMatrixControl setEnabled:YES];
		[progress stopAnimation:self];
		[archiveButton setEnabled:YES];
		[closeControl setEnabled:YES];
		[maxLoopsField setEnabled:YES];
		[archThreadPool release];
		archThreadPool = NULL;
		[thread release];
		thread = NULL;
	}
}

- (IBAction)archive:(id)sender 
{
// 0) parameters validation

	// n -> width, m -> height
	if ([logWith state])
	{
		if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"[1-9][0-9]*"] 
									evaluateWithObject:[logEachValue stringValue]] == YES)
			ilogEachValue = [logEachValue intValue];
		else 
		{
			NSRunAlertPanel(@"Warning", @"Wrong input on 'log each'", @"Ok", nil, nil);
			return;
		}

	}
	if (!neuroNet)
		neuroNet = [ImageNeuroNet tryInit:[sourceImage image] 
									 nStr:[n stringValue] 
									 mStr:[m stringValue] 
									 pStr:[p stringValue] 
									 aStr:[a stringValue]
									 dStr:[D stringValue]
						   TeachZeroLayer:[teachZeroLayer state]
						  UseAdaptiveStep:[adaptiveSteps state]
						  ShouldNormalize:[normilizingWith state]
					];	
	if (thread)
		[thread cancel];
	if (![thread isExecuting])
	{
		[thread release];
		thread = NULL;
	}	
	if (thread == NULL)
		thread = [[NSThread alloc] initWithTarget:self selector:@selector(neuro_arch) object:nil];
	[thread start];
	
}
- (IBAction)close:(id)sender 
{
	if (thread)
	{
		[thread cancel];
		if (archThreadPool)
		{
			[archThreadPool release];
			archThreadPool = NULL;
		}
		[thread release];
		thread = NULL;
	}
	if (neuroNet)
	{
		[neuroNet release];
		neuroNet = NULL;
	}
	if ([sourceImage image])
	{
		NSImage* image = [sourceImage image];
		[sourceImage setImage:nil];
		[image release];
	}
	if ([resultImage image])
	{
		[resultImage setImage:nil];
	}
	[self disableControls];
	[openSourceImageControl setEnabled:YES];
}
- (IBAction)logWithClicked:(id)sender
{
	if (!withLogBool)
	{
		[logEachValue setHidden:NO];
		[logEachValueLabel setHidden:NO];
		withLogBool = TRUE;
	}
	else 
	{
		[logEachValue setHidden:YES];
		[logEachValueLabel setHidden:YES];
		withLogBool = FALSE;
	}

}
@end
