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
@property (nonatomic, strong) NSArray *nearbyBeacons;

+ (HBMBeaconController *)sharedController;

/**
 Enables monitoring of any added children with a ranging mode. Notifications will be sent when a child is going out of range and has gone out of range
 **/
- (void)startMonitoringChildren;

/**
 Disables monitoring of any children in the list of added children
 **/
- (void)stopMonitoringChildren;

@end
