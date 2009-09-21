//
//  ImageAlgorythms.h
//  NeuroArchivator
//
//  Created by Ivan Sidarau on 10.09.09.
//  Copyright 2009 rilley_elf corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ImageAlgorythms : NSObject 
{
}
+(BOOL) validateImageOnRGB:(NSImage*)image;
+(void) getImageSize:(NSImage*)image h:(int*)hs w:(int*)ws l:(int*)ls;
@end
