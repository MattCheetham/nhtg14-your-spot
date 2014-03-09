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

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        
        self.childName = [decoder decodeObjectForKey:@"HBMChildName"];
        self.childImage = [decoder decodeObjectForKey:@"HBMChildImage"];
        self.beaconRegion = [decoder decodeObjectForKey:@"HBMBeaconRegion"];

    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.childName forKey:@"HBMChildName"];
    [coder encodeObject:self.childImage forKey:@"HBMChildImage"];
    [coder encodeObject:self.beaconRegion forKey:@"HBMBeaconRegion"];
}

@end
