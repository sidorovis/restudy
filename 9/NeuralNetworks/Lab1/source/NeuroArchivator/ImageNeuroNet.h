//
//  ImageNeuroNet.h
//  NeuroArchivator
//
//  Created by Ivan Sidarau on 16.09.09.
//  Copyright 2009 rilley_elf corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NeuroNet.h"
#import "ImageNeuronLay.h"
#import "ImageAlgorythms.h"
#import "ImageBlockIterator.h"

#define layers_count 2
#define color_basis 255.0

@interface ImageNeuroNet : NeuroNet
{
	int		width, 
	height; // rectangle sizes

	NSImage* image;
	double saveDiff;
	
	SEL* colorSelectors;
	int colorSelectorCount;
	bool teachZeroLayer;
	bool useAdaptiveStep;
	bool shouldNormilize;
}
+ (void) testOnInt:(NSString*)value errorStr:(NSString**)answer errorStrV:(NSString*)err result:(int*)result;
+ (BOOL) validateParams:(NSString*)n_ m:(NSString*)m_ p:(NSString*)p_ a:(NSString*)a_ d:(NSString*)d_ n_i:(int*)n m_i:(int*)m p_i:(int*)p a_f:(double*)a d_i:(int*)d;
+ (ImageNeuroNet*) tryInit:(NSImage*)image nStr:(NSString*)nStr mStr:(NSString*)mStr 
					  pStr:(NSString*)pStr aStr:(NSString*)aStr dStr:(NSString*)dStr
			TeachZeroLayer:(bool)teachZeroLayer_
		   UseAdaptiveStep:(bool)useAdaptiveStep_
		   ShouldNormalize:(bool)shouldNormalize_;

- (ImageNeuroNet*) initWithImage:(NSImage*)image_ width:(int)width_ height:(int)height_ 
				  neuronCountOn1:(int)neuronCountOn1_ a:(double)teachK_ d:(int)enoughK_
				  TeachZeroLayer:(bool)teachZeroLayer_
				 UseAdaptiveStep:(bool)useAdaptiveStep_
				 ShouldNormalize:(bool)shouldNormalize_;
- (void) dealloc;
- (BOOL) fastGoodEnough:(double*)diff;
- (void) fastTeach:(double*)currTeachK;

- (void) normilizeX:(double*)vector;
- (void) fastTeachByColor:(double*)inputColorArray;

- (void) saveState;
- (void) loadState;
-(NSImage*) getResultImage;

@end
