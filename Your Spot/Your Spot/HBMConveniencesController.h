//
//  HBMConveniencesController.h
//  Your Spot
//
//  Created by Matthew Cheetham on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

@class HBMConvenience;

#import <Foundation/Foundation.h>

@interface HBMConveniencesController : NSObject

@property (nonatomic, strong) NSMutableArray *conveniences;

typedef void (^HBMNearestConvenienceCompletion)(NSArray *conveniences, NSError *error);

+ (HBMConveniencesController *)sharedController;

/**
 Gets the nearest convenience to the users current location
 @param location The users current location
 @param completion the HBMNearestConvenienceCompletion block to call when we have found a location or failed to find any nearby conveniences
 **/
- (void)nearestConveniencesWithLocation:(CLLocation *)location completion:(HBMNearestConvenienceCompletion)completion;

@end
