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
        self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"2AD6C139-2052-441D-83B0-316CEB8DD7A1"] identifier:@"child"];
//        self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"] identifier:@"child"];
    }
    return self;
}

@end
