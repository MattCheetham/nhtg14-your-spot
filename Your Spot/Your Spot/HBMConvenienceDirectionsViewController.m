//
//  HBMConvenienceDirectionsViewController.m
//  Your Spot
//
//  Created by Matthew Cheetham on 09/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "HBMConvenienceDirectionsViewController.h"
#import "HBMConveniencesController.h"
#import "PCSingleRequestLocationManager.h"
#import "HBMConvenience.h"
#import <MapKit/MapKit.h>

@interface HBMConvenienceDirectionsViewController ()

@property (nonatomic, strong) HBMConveniencesController *conveniencesController;
@property (nonatomic, strong) MKRoute *route;
@property (nonatomic, strong) NSArray *directions;
@property (nonatomic, strong) HBMConvenience *convenience;

@end

@implementation HBMConvenienceDirectionsViewController

- (id)initWithConvenience:(HBMConvenience *)convenience
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {

        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        self.conveniencesController = [HBMConveniencesController sharedController];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PCSingleRequestLocationManager *manager = [PCSingleRequestLocationManager new];
    [manager requestCurrentLocationWithCompletion:^(CLLocation *location, NSError *error) {
        
        CLGeocoder *geocoder = [CLGeocoder new];
        
        [self.conveniencesController nearestConveniencesWithLocation:location completion:^(NSArray *conveniences, NSError *error) {
            
            self.convenience = conveniences[0];
            
            [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
                
                CLPlacemark *foundPlacemark = placemarks[0];
                MKPlacemark *newPlacemark = [[MKPlacemark alloc] initWithCoordinate:foundPlacemark.location.coordinate addressDictionary:foundPlacemark.addressDictionary];
                MKMapItem *source = [[MKMapItem alloc] initWithPlacemark:newPlacemark];
                
                [geocoder geocodeAddressString:((HBMConvenience *)conveniences[0]).convenienceAddress completionHandler:^(NSArray *placemarks, NSError *error) {
                    
                    CLPlacemark *foundPlacemark = placemarks[0];
                    MKPlacemark *newPlacemark = [[MKPlacemark alloc] initWithCoordinate:foundPlacemark.location.coordinate addressDictionary:foundPlacemark.addressDictionary];
                    MKMapItem *destination = [[MKMapItem alloc] initWithPlacemark:newPlacemark];

                    MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc] init];
                    directionsRequest.source = source;
                    directionsRequest.destination = destination;
                    directionsRequest.requestsAlternateRoutes = NO;
                    directionsRequest.transportType = MKDirectionsTransportTypeWalking;
                    
                    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
                    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
                        
                        self.route = response.routes[0];
                        
                        self.directions = self.route.steps;
                        NSLog(@"I have directions:%@", response);
                        NSLog(@"Error:%@", error);
                        
                        [self.tableView reloadData];
                        
                    }];
                    
                }];
                
            }];

        }];
        
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(self.route){
        return [NSString stringWithFormat:@"%@ - %.0fm away", self.convenience.convenienceName, self.route.distance];
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.directions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = ((MKRouteStep *)self.directions[indexPath.row]).instructions;
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *direction = ((MKRouteStep *)self.directions[indexPath.row]).instructions;
    
    CGSize constraint = CGSizeMake(290, MAXFLOAT);
    
    CGSize size = [direction sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat height = MAX(size.height + 11, 44.0f);
    
    return height;
}

@end
