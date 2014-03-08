//
//  HBMConveniencesController.h
//  Your Spot
//
//  Created by Matthew Cheetham on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBMConveniencesController : NSObject

@property (nonatomic, strong) NSMutableArray *conveniences;

+ (HBMConveniencesController *)sharedController;

@end
