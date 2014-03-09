//
//  HBMChild.m
//  Your Spot
//
//  Created by Matthew Cheetham on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "HBMChild.h"

@implementation HBMChild

- (id)init
{
    self = [super init];
    if (self) {
        self.beaconRegion.notifyEntryStateOnDisplay = YES;
        self.beaconRegion.notifyOnEntry = YES;
        self.beaconRegion.notifyOnExit = YES;
        self.currentProximity = CLProximityUnknown;
    }
    return self;
}

@end
