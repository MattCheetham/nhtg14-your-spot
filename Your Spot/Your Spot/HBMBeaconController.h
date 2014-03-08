//
//  HBMBeaconController.h
//  Your Spot
//
//  Created by Matthew Cheetham on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBMBeaconController : NSObject

@property (nonatomic, strong) NSMutableArray *monitoredFriends;
@property (nonatomic, strong) NSMutableArray *monitoredChildren;

+ (HBMBeaconController *)sharedController;

@end
