//
//  HBMNearbyPeopleViewController.m
//  Your Spot
//
//  Created by Daniel Tomlinson on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "HBMNearbyPeopleViewController.h"
#import "HBMConcentricCircleView.h"
#import "HBMProfileImageView.h"

@interface HBMNearbyPeopleViewController ()

@end

@implementation HBMNearbyPeopleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        HBMConcentricCircleView *circleView = [[HBMConcentricCircleView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
        circleView.center = self.view.center;
        
        [self.view addSubview:circleView];
        
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
