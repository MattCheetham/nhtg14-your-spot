//
//  HBMConvenience.h
//  Your Spot
//
//  Created by Matthew Cheetham on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBMConvenience : NSObject

@property (nonatomic, strong) NSString *convenienceName;
@property (nonatomic, strong) NSString *convenienceAddress;
@property (nonatomic, strong) CLLocation *convenienceLocation;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
