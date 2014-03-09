//
//  HBMNearbyPeopleViewController.m
//  Your Spot
//
//  Created by Daniel Tomlinson on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "HBMNearbyPeopleViewController.h"
#import "HBMProfileImageView.h"
#import "HBMNearbyDevicesView.h"
#import "HBMConveniencesController.h"
#import "HBMBeaconController.h"
#import "HBMChild.h"
#import "HBMNearbyBeaconTableViewController.h"


@interface HBMNearbyPeopleViewController ()
@property (nonatomic, weak) HBMNearbyDevicesView *nearbyDevicesView;
@end

@implementation HBMNearbyPeopleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        HBMNearbyDevicesView *view =  [[HBMNearbyDevicesView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
        view.center = self.view.center;
        
        [[HBMBeaconController sharedController].monitoredChildren enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             HBMChild *child = (HBMChild *)obj;
             HBMProfileImageView *profileView = [[HBMProfileImageView alloc] initWithImage:child.childImage
                                                                                     frame:CGRectMake(0, 0, 50, 50)];
             
             
             [view addProfileView:profileView withTier:child.currentProximity];
        }];
        
        [self.view addSubview:view];
        self.nearbyDevicesView = view;
        
        [[HBMBeaconController sharedController] addObserver:self
                                                 forKeyPath:@"monitoredChildren"
                                                    options:kNilOptions
                                                    context:Nil];
        
        UIBarButtonItem *addBeacon = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
    target:self
                                                                                   action:@selector(showBeaconThing)];
        
        self.navigationItem.rightBarButtonItem = addBeacon;
    }
    
    return self;
}

- (void)showBeaconThing
{
    HBMNearbyBeaconTableViewController *beaconTableViewController = [HBMNearbyBeaconTableViewController new];
    
    [self.navigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:beaconTableViewController] animated:YES completion:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self.nearbyDevicesView clearAll];
    
    [[HBMBeaconController sharedController].monitoredChildren enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         HBMChild *child = (HBMChild *)obj;
         HBMProfileImageView *profileView = [[HBMProfileImageView alloc] initWithImage:child.childImage
                                                                                 frame:CGRectMake(0, 0, 50, 50)];
         
         
         [self.nearbyDevicesView addProfileView:profileView withTier:(child.currentProximity == CLProximityNear ? 1 : 3)];
     }];

}

- (void)dealloc
{
    [[HBMBeaconController sharedController] removeObserver:self
                                                forKeyPath:@"monitoredChildren"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[HBMBeaconController sharedController] startMonitoringChildren];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[HBMBeaconController sharedController] stopMonitoringChildren];

}

@end
