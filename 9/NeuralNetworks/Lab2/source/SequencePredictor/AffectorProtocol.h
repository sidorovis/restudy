//
//  AffectorProtocol.h
//  SequencePredictor
//
//  Created by Ivan Sidarau on 24.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol AffectorProtocol

-(void) affectWith:(double) value_;
-(double) getValue;
-(void) teachAffector:(double)alpha xValue:(double)value_;
-(void) normilizeAffect:(double)summ;
-(void) debug;
@end
