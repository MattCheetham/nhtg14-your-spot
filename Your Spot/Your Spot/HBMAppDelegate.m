//
//  HBMAppDelegate.m
//  Your Spot
//
//  Created by Matthew Cheetham on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "HBMAppDelegate.h"
#import "HBMConveniencesController.h"
#import "HBMBeaconController.h"
#import "HBMNearbyBeaconTableViewController.h"

@implementation HBMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    HBMNearbyBeaconTableViewController *addBeacon = [HBMNearbyBeaconTableViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addBeacon];
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

@end
