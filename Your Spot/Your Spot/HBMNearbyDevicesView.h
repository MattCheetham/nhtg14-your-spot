//
//  HBMNearbyDevicesView.h
//  Your Spot
//
//  Created by Daniel Tomlinson on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "HBMConcentricCircleView.h"

@class HBMProfileImageView;

@interface HBMNearbyDevicesView : HBMConcentricCircleView

- (void)addProfileView:(HBMProfileImageView *)profileView withTier:(NSUInteger)tier;

@end
