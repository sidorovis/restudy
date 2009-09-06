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
	if ( [openPanel runModalForTypes:[[NSArray alloc] initWithObjects:@"jpg", @"tif", @"png", nil]] == NSOKButton )
	{
		[sourceImage setImage:[[NSImage alloc] initWithContentsOfFile:[openPanel filename] ] ];
		[archiveButton setEnabled:YES];
		[openSourceImageControl setEnabled:NO];
		[openArchiveMatrixControl setEnabled:YES];
		[closeControl setEnabled:YES];
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

- (IBAction)archive:(id)sender 
{
//	[table setString:];
}

- (IBAction)deArchive:(id)sender 
{
    
}

- (IBAction)close:(id)sender 
{
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
