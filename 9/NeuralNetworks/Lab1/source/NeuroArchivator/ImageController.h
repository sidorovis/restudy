#import <Cocoa/Cocoa.h>
#import "ImageNeuroNet.h"


@interface ImageController : NSObject {
    IBOutlet NSImageView *resultImage;
	NSImage* resultImageInstance;
    IBOutlet NSImageView *sourceImage;
    IBOutlet NSButton *archiveButton;
    IBOutlet NSMenuItem *openArchiveMatrixControl;
    IBOutlet NSMenuItem *openSourceImageControl;
    IBOutlet NSMenuItem *saveArchiveMatrixControl;
    IBOutlet NSMenuItem *closeControl;
    IBOutlet NSTextField *m; // width of rectangles
    IBOutlet NSTextField *n; // height of rectangles
    IBOutlet NSTextField *p; // elements on first level
    IBOutlet NSTextField *a; // const alpha koeficient
    IBOutlet NSTextField *D; // minimal differencie value between images
	IBOutlet NSTextField *maxLoopsField;
	IBOutlet NSTextField *currA;
	IBOutlet NSTextField *currD;
	IBOutlet NSTextField *loopRes;
	IBOutlet NSProgressIndicator* progress;
	ImageNeuroNet* neuroNet;
	NSThread* thread;
}
- (IBAction)archive:(id)sender;
- (IBAction)loadSourceImage:(id)sender;
- (IBAction)loadArchiveMatrix:(id)sender;
- (IBAction)saveArchiveMatrix:(id)sender;
- (IBAction)close:(id)sender;
- (void) neuro_arch;
- (void) enableControls;
- (void) disableControls;
@end
