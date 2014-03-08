//
//  HBMConveniencesController.m
//  Your Spot
//
//  Created by Matthew Cheetham on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "HBMConveniencesController.h"
#import "HBMConvenience.h"

@interface HBMConveniencesController ()

@end

@implementation HBMConveniencesController

static HBMConveniencesController *sharedController = nil;

+ (HBMConveniencesController *)sharedController
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
        
        self.conveniences = [NSMutableArray array];
        
        [self refreshConveniences];
        
    }
    return self;
}

- (void)refreshConveniences
{
    NSString *conveniencePath = [[NSBundle mainBundle] pathForResource:@"conveniences" ofType:@"json"];
    NSData *convenienceData = [NSData dataWithContentsOfFile:conveniencePath];
    NSArray *conveniencesArray = [NSJSONSerialization JSONObjectWithData:convenienceData options:NSJSONReadingAllowFragments error:nil];
    
    for (NSDictionary *convenienceInformation in conveniencesArray){
        
        HBMConvenience *convenience = [[HBMConvenience alloc] initWithDictionary:convenienceInformation];
        
        [self.conveniences addObject:convenience];
        
    }
}

- (void)nearestConveniencesWithLocation:(CLLocation *)location completion:(HBMNearestConvenienceCompletion)completion
{
    
    NSArray *sortedLocations = [self.conveniences sortedArrayUsingComparator:^NSComparisonResult(HBMConvenience *obj1, HBMConvenience *obj2) {
        
        CLLocationDistance distance1 = [location distanceFromLocation:obj1.convenienceLocation];
        CLLocationDistance distance2 = [location distanceFromLocation:obj2.convenienceLocation];
        
        if (distance1 < distance2) {
            
            return NSOrderedAscending;
            
        } else if (distance1 > distance2) {
            
            return NSOrderedDescending;
            
        } else {
            
            return NSOrderedSame;
            
        }
        
    }];
    
    
    completion(sortedLocations, nil);
    
}

@end
