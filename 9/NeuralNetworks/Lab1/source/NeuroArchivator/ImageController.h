#import <Cocoa/Cocoa.h>

@interface ImageController : NSObject {
    IBOutlet NSImageView *resultImage;
    IBOutlet NSImageView *sourceImage;
    IBOutlet NSButton *archiveButton;
    IBOutlet NSButton *deArchiveButton;
    IBOutlet NSMenuItem *openArchiveMatrixControl;
    IBOutlet NSMenuItem *openSourceImageControl;
    IBOutlet NSMenuItem *saveArchiveMatrixControl;
    IBOutlet NSMenuItem *saveResultImageControl;
    IBOutlet NSMenuItem *closeControl;
    IBOutlet NSTextView *table;
}
- (IBAction)archive:(id)sender;
- (IBAction)loadSourceImage:(id)sender;
- (IBAction)loadArchiveMatrix:(id)sender;
- (IBAction)saveResultImage:(id)sender;
- (IBAction)saveArchiveMatrix:(id)sender;
- (IBAction)deArchive:(id)sender;
- (IBAction)close:(id)sender;
@end
