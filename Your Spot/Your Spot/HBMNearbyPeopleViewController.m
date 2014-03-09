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
@interface HBMNearbyPeopleViewController ()

@end

@implementation HBMNearbyPeopleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        HBMNearbyDevicesView *circleView = [[HBMNearbyDevicesView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
        circleView.center = self.view.center;
        
        [self.view addSubview:circleView];
        
        HBMProfileImageView *profileView = [[HBMProfileImageView alloc] initWithImage:[UIImage imageNamed:@"test"] frame:CGRectMake(0, 0, 50, 50)];
        
        [circleView addProfileView:profileView withTier:1];
        
        HBMProfileImageView *profileView2 = [[HBMProfileImageView alloc] initWithImage:[UIImage imageNamed:@"test"] frame:CGRectMake(0, 0, 50, 50)];
        
        [circleView addProfileView:profileView2 withTier:1];
        
        HBMProfileImageView *profileView3 = [[HBMProfileImageView alloc] initWithImage:[UIImage imageNamed:@"test"] frame:CGRectMake(0, 0, 50, 50)];
        
        [circleView addProfileView:profileView3 withTier:1];
        
        HBMProfileImageView *profileView4 = [[HBMProfileImageView alloc] initWithImage:[UIImage imageNamed:@"test"] frame:CGRectMake(0, 0, 50, 50)];
        
        [circleView addProfileView:profileView4 withTier:2];
        
    }
    return self;
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

@end
