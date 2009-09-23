#import <Cocoa/Cocoa.h>
#import "ImageNeuroNet.h"

#define MAX_LOOP_COUNTER 8

@interface ImageController : NSObject {
    IBOutlet NSImageView *resultImage;
	NSImage* resultImageInstance;
    IBOutlet NSImageView *sourceImage;
    IBOutlet NSButton *archiveButton;
    IBOutlet NSMenuItem *openArchiveMatrixControl;
    IBOutlet NSMenuItem *openSourceImageControl;
    IBOutlet NSMenuItem *saveArchiveMatrixControl;
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
- (IBAction)saveArchiveMatrix:(id)sender;
- (IBAction)close:(id)sender;
@end
