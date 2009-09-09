#import <Cocoa/Cocoa.h>

#define RANDOM_MULTIMIZATOR 100

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
    IBOutlet NSTextField *m;
    IBOutlet NSImageView *middleImage;
    IBOutlet NSTextField *n;
    IBOutlet NSTextField *p;
    IBOutlet NSTextField *a;
	int i_n;
	int i_m;
	int i_p;
	double i_a;
	NSMutableArray* w;
}
+ (void) getImageSize:(NSImage*)image h:(int*)hs w:(int*)ws l:(int*)ls;
+ (float) compareImage:(NSImage*)left withImage:(NSImage*)right;
+ (float) comparePartOfImage:(NSImage*)left withImage:(NSImage*)right x_s:(int)x_s y_s:(int)y_s x_f:(int)x_f y_f:(int)y_f;
- (void) printW0Matrix;
- (void) createW0Matrix;
- (IBAction)archive:(id)sender;
+ (void)testOnInt:(NSString*)value errorStr:(NSString**)answer errorStrV:(NSString*)err result:(int*)result;
- (IBAction)loadSourceImage:(id)sender;
- (IBAction)loadArchiveMatrix:(id)sender;
- (IBAction)saveResultImage:(id)sender;
- (IBAction)saveArchiveMatrix:(id)sender;
- (IBAction)deArchive:(id)sender;
- (IBAction)close:(id)sender;
@end
