//
//  HBMConvenience.m
//  Your Spot
//
//  Created by Matthew Cheetham on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "HBMConvenience.h"

@implementation HBMConvenience

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        self.convenienceName = dictionary[@"Sub_Building_Name"];
        self.convenienceAddress = dictionary[@"FULL_ADDRESS"];
        self.convenienceLocation = [[CLLocation alloc] initWithLatitude:[dictionary[@"x"] doubleValue] longitude:[dictionary[@"y"] doubleValue]];
        
    }
    return self;
}

@end
