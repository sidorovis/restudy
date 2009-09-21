#import <Cocoa/Cocoa.h>
#import "ImageNeuroNet.h"

@interface ImageController : NSObject {
    IBOutlet NSImageView *resultImage;
	NSImage* resultImageInstance;
    IBOutlet NSImageView *sourceImage;
    IBOutlet NSButton *archiveButton;
    IBOutlet NSButton *deArchiveButton;
    IBOutlet NSMenuItem *openArchiveMatrixControl;
    IBOutlet NSMenuItem *openSourceImageControl;
    IBOutlet NSMenuItem *saveArchiveMatrixControl;
    IBOutlet NSMenuItem *saveResultImageControl;
    IBOutlet NSMenuItem *closeControl;
    IBOutlet NSTextView *table;
    IBOutlet NSTextField *m;
    IBOutlet NSTextField *n;
    IBOutlet NSTextField *p;
    IBOutlet NSTextField *a;
    IBOutlet NSTextField *D;
	ImageNeuroNet* neuroNet;
}
- (IBAction)archive:(id)sender;
- (IBAction)loadSourceImage:(id)sender;
- (IBAction)loadArchiveMatrix:(id)sender;
- (IBAction)saveResultImage:(id)sender;
- (IBAction)saveArchiveMatrix:(id)sender;
- (IBAction)deArchive:(id)sender;
- (IBAction)close:(id)sender;
@end
