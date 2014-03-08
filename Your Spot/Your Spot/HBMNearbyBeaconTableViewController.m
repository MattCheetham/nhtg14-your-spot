//
//  HBMNearbyBeaconTableViewController.m
//  Your Spot
//
//  Created by Matthew Cheetham on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "HBMNearbyBeaconTableViewController.h"
#import "HBMBeaconController.h"

@interface HBMNearbyBeaconTableViewController ()

@property (nonatomic, strong) HBMBeaconController *beaconController;

@end

@implementation HBMNearbyBeaconTableViewController

- (void)dealloc
{
    [self.beaconController removeObserver:self forKeyPath:@"nearbyBeacons"];
}

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        self.beaconController = [HBMBeaconController sharedController];
        
        [self.beaconController addObserver:self forKeyPath:@"nearbyBeacons" options:kNilOptions context:nil];
        
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.beaconController.nearbyBeacons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CLBeacon *nearbyBeacon = self.beaconController.nearbyBeacons[indexPath.row];
    cell.textLabel.text = nearbyBeacon.proximityUUID.UUIDString;
    
    return cell;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self.tableView reloadData];
}
@end
