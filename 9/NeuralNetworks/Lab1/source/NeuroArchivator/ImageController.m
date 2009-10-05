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
	}
	[types release];	
	neuroNet = NULL;
	resultImageInstance = NULL;
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
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	if (!neuroNet)
	{
		[pool release];
		return;
	}
	
	int loopCounter = 0;
	NSString* loops_error = @"";
	int maxLoops;
	[ImageNeuroNet testOnInt:[maxLoopsField stringValue] errorStr:&loops_error errorStrV:@"loop " result:&maxLoops];
	if (loops_error != @"")
	{
		NSRunAlertPanel(@"Warning", [@"Wrong input on " stringByAppendingString:loops_error], @"Ok", nil, nil);
		[pool release];
		return;
	}	
	
	[self disableControls];
	[closeControl setEnabled:FALSE];
	[archiveButton setEnabled:FALSE];
	[progress startAnimation:self];
	float diff;
	float alpha;
	while ([neuroNet fastGoodEnough:&diff] == NO)
	{
		[neuroNet fastTeach:&alpha];
		loopCounter++;
		if (loopCounter > maxLoops)
			break;
		[loopRes setStringValue:[NSString stringWithFormat:@"%d", loopCounter]];
		[currD setStringValue:[NSString stringWithFormat:@"%f", diff]];
		[currA setStringValue:[NSString stringWithFormat:@"%f", alpha]];
	}
	resultImageInstance = [neuroNet getResultImage];
	[resultImage setImage:resultImageInstance];
	[resultImageInstance release];
	resultImageInstance = NULL;

	[saveArchiveMatrixControl setEnabled:YES];
	
	[progress stopAnimation:self];
	[archiveButton setEnabled:YES];
	[closeControl setEnabled:YES];
	[maxLoopsField setEnabled:YES];
	[pool drain];
	[pool release];
}

- (IBAction)archive:(id)sender 
{
// 0) parameters validation

	// n -> width, m -> height
	if (!neuroNet)
		neuroNet = [ImageNeuroNet tryInit:[sourceImage image] 
									 nStr:[n stringValue] 
									 mStr:[m stringValue] 
									 pStr:[p stringValue] 
									 aStr:[a stringValue]
									 dStr:[D stringValue]
						   TeachZeroLayer:[teachZeroLayer state]
						  UseAdaptiveStep:[adaptiveSteps state]
					];	
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
	if (resultImageInstance)
		[resultImageInstance release];
	if ([resultImage image])
	{
		NSImage* image = [resultImage image];
		[resultImage setImage:nil];
		[image release];
	}
	[self disableControls];
	[openSourceImageControl setEnabled:YES];

}
@end
