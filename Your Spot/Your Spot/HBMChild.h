//
//  HBMChild.h
//  Your Spot
//
//  Created by Matthew Cheetham on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBMChild : NSObject <NSCoding>

@property (nonatomic, strong) NSString *childName;
@property (nonatomic, strong) UIImage *childImage;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@property (nonatomic) CLProximity currentProximity;

@end
