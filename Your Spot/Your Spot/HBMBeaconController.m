//
//  HBMBeaconController.m
//  Your Spot
//
//  Created by Matthew Cheetham on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "HBMBeaconController.h"

@implementation HBMBeaconController

static HBMBeaconController *sharedController = nil;

+ (HBMBeaconController *)sharedController
{
    @synchronized(self) {
        if (sharedController == nil) {
            sharedController = [[self alloc] init];
        }
    }
    return sharedController;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

@end
