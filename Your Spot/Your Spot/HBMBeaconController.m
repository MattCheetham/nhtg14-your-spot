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
@property (nonatomic, strong) NSMutableArray *monitoredRegions;

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
        self.nearbyBeacons = [NSMutableArray array];
        self.monitoredRegions = [NSMutableArray array];
        self.nearbyBeaconDictionary = [NSMutableDictionary dictionary];
                        
    }
    return self;
}

#pragma mark - Add/Remove monitored people

- (void)addMonitoredChild:(HBMChild *)child
{
    [self.monitoredChildren addObject:child];
}

#pragma mark - Handle start/stop of monitoring

- (void)startLookingForNearbyBeacons
{
    //List of beacon brands we need to look for, and our own
    CLBeaconRegion *estimoteRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"] identifier:@"Estimote"];
    CLBeaconRegion *appRegion = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:kYourSpotUUUID] identifier:@"Your Spot User"];
    
    [self.monitoredRegions addObjectsFromArray:@[estimoteRegion, appRegion]];
    
    for (CLBeaconRegion *region in self.monitoredRegions){
        [self.locationManager startRangingBeaconsInRegion:region];
    }
}

- (void)stopLookingForNearbyBeacons
{
    for (CLBeaconRegion *monitoredRegion in self.monitoredRegions){
        
        [self.locationManager stopRangingBeaconsInRegion:monitoredRegion];
        
    }
}

- (void)startMonitoringFriends
{

}

- (void)stopMonitoringFriends
{
    
}

- (void)startMonitoringChildren
{
    for (HBMChild *child in self.monitoredChildren){
        
        [self.locationManager startRangingBeaconsInRegion:child.beaconRegion];
        
    }
}

- (void)stopMonitoringChildren
{
    for (HBMChild *child in self.monitoredChildren){
        
        [self.locationManager stopRangingBeaconsInRegion:child.beaconRegion];
        
    }
}

#pragma mark - Region Range handling
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    
    [self.nearbyBeaconDictionary setObject:beacons forKey:region.identifier];
    
    [self.nearbyBeacons removeAllObjects];

    [self willChangeValueForKey:@"nearbyBeacons"];
    for (NSString *key in [self.nearbyBeaconDictionary allKeys]){
        
        [self.nearbyBeacons addObjectsFromArray:self.nearbyBeaconDictionary[key]];
        
    }
    [self didChangeValueForKey:@"nearbyBeacons"];
    
//    CLBeacon *firstBeacon = [beacons firstObject];
//    NSLog(@"Updated with range:%@", [self stringFromProximity:firstBeacon.proximity]);
//    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
//    localNotif.alertBody = [NSString stringWithFormat:@"Updated with range:%@", [self stringFromProximity:firstBeacon.proximity]];
//    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotif];
}

- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    NSLog(@"Failed to range");
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    
    if (state == CLRegionStateInside) {
        
        NSLog(@"Inside");
    }
    
    else{
        
        NSLog(@"Outside");
        
    }
    
}

#pragma mark - Region Enter/Exit

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"Found them!");
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    localNotif.alertBody = @"Found them!";
    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotif];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog(@"Lost them!");
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    localNotif.alertBody = @"Lost them!";
    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotif];

}

#pragma mark - Monitoring convneience methods

- (NSString *)commonIdentifierForBeacon:(CLBeacon *)beacon
{
    for (CLBeaconRegion *existingBeacon in self.monitoredRegions){
        
        if([existingBeacon.proximityUUID.UUIDString isEqualToString:beacon.proximityUUID.UUIDString]){
            
            return existingBeacon.identifier;
            break;
            
        }
        
    }

    return @"Unknown";
}

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
