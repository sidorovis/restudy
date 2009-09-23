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
		[archiveButton setEnabled:YES];
		[openSourceImageControl setEnabled:NO];
		[closeControl setEnabled:YES];
		[openArchiveMatrixControl setEnabled:NO];
		[n setEnabled:YES];	// n -> width
		[m setEnabled:YES]; // m -> height
		[p setEnabled:YES];
		[a setEnabled:YES];
		[D setEnabled:YES];
		[progress setUsesThreadedAnimation:YES];
		[progress setMinValue:0];
		[progress setDoubleValue:0.0];
		[progress setMaxValue:MAX_LOOP_COUNTER];
		
	}
	[types release];	
	neuroNet = NULL;
	resultImageInstance = NULL;
	thread = NULL;
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
		NSString* filename = [[savePanel filename] stringByAppendingString:@"" ];
		NSString* neuroNetStrRepresentation = [[NSString alloc] initWithFormat:@"%@", neuroNet];
		[ neuroNetStrRepresentation writeToFile:filename atomically:NO];
	}
}
- (void) neuro_arch
{
	[closeControl setEnabled:FALSE];
	[archiveButton setEnabled:FALSE];
	[progress startAnimation:self];

	if (!neuroNet)
		neuroNet = [ImageNeuroNet tryInit:[sourceImage image] 
									 nStr:[n stringValue] 
									 mStr:[m stringValue] 
									 pStr:[p stringValue] 
									 aStr:[a stringValue]
									 dStr:[D stringValue]];
	
	int loopCounter = 0;
	while ([neuroNet fastGoodEnough] == NO)
	{
		loopCounter++;
		[table setString:[[NSString alloc] initWithFormat:@"%d",loopCounter]];
		if (loopCounter > MAX_LOOP_COUNTER)
			break;
		[neuroNet fastTeach];
	}
	resultImageInstance = [neuroNet getResultImage];
	[resultImage setImage:resultImageInstance];
	[resultImageInstance release];
	resultImageInstance = NULL;
	[saveArchiveMatrixControl setEnabled:YES];

	[progress stopAnimation:self];
	[archiveButton setEnabled:TRUE];
	[closeControl setEnabled:TRUE];
	thread = NULL;
}


- (IBAction)archive:(id)sender 
{
// 0) parameters validation

	// n -> width, m -> height
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
	[openSourceImageControl setEnabled:YES];
	[openArchiveMatrixControl setEnabled:YES];
	[saveArchiveMatrixControl setEnabled:NO];
	[archiveButton setEnabled:NO];
	[closeControl setEnabled:NO];
	[table setString:@""];
}
@end
