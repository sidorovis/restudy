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
		[openArchiveMatrixControl setEnabled:YES];
		[closeControl setEnabled:YES];
		[n setEnabled:YES];	// n -> width
		[m setEnabled:YES]; // m -> height
		[p setEnabled:YES];
		[a setEnabled:YES];
		[D setEnabled:YES];
	}
	[types release];	
	neuroNet = NULL;
	resultImageInstance = NULL;
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
								 dStr:[D stringValue]];
	
	int loopCounter = 0;
	while ([neuroNet goodEnough] == NO)
	{
		loopCounter++;
		if (loopCounter > MAX_LOOP_COUNTER)
			break;
		[neuroNet teach];
	}
	resultImageInstance = [neuroNet getResultImage];
	[resultImage setImage:resultImageInstance];
	[resultImageInstance release];
	[neuroNet release];
	neuroNet = NULL;
	
}
- (IBAction)deArchive:(id)sender 
{
    
}

- (IBAction)close:(id)sender 
{
	if (neuroNet)
		[neuroNet release];
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
	[table setString:@""];
	if (resultImageInstance)
		[resultImageInstance release];
}
@end
