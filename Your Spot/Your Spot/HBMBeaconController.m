//
//  HBMBeaconController.m
//  Your Spot
//
//  Created by Matthew Cheetham on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "HBMBeaconController.h"
#import "HBMChild.h"

@interface HBMBeaconController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

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
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.monitoredChildren = [NSMutableArray array];
        self.monitoredFriends = [NSMutableArray array];
        
        [self.monitoredChildren addObject:[[HBMChild alloc] init]];
        
        [self startMonitoringChildren];
        
    }
    return self;
}

#pragma mark - Handle start/stop of monitoring

- (void)startMonitoringFriends
{

}

- (void)stopMonitoringFriends
{
    
}

- (void)startMonitoringChildren
{
    for (HBMChild *child in self.monitoredChildren){
        
        [self.locationManager startMonitoringForRegion:child.beaconRegion];
        [self.locationManager startRangingBeaconsInRegion:child.beaconRegion];
        
    }
}

- (void)stopMonitoringChildren
{
    
}

#pragma mark - Region handling
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    CLBeacon *firstBeacon = [beacons firstObject];
    NSLog(@"Updated with range:%@", [self stringFromProximity:firstBeacon.proximity]);
}

- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    NSLog(@"Failed to range");
}
          
#pragma mark - Proximity convneience methods

- (NSString *)stringFromProximity:(CLProximity)proximity
{
    switch (proximity) {
        case CLProximityFar:
            return @"Far away";
            break;
        case CLProximityImmediate:
            return @"Immediate";
            break;
        case CLProximityNear:
            return @"Nearby";
            break;
        case CLProximityUnknown:
            return @"Unknown";
            break;
            
        default:
            break;
    }
}
@end
