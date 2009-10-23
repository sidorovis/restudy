//
//  RandomAffect.h
//  SequencePredictor
//
//  Created by Ivan Sidarau on 24.10.09.
//  Copyright 2009 Rilley_Elf Corp. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Affect.h"

@interface RandomAffect : Affect {

}
-(RandomAffect*) initRandomTo:(Neuron*)neuron_;

@end
