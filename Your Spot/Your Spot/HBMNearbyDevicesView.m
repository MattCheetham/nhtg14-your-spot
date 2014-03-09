//
//  HBMNearbyDevicesView.m
//  Your Spot
//
//  Created by Daniel Tomlinson on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "HBMNearbyDevicesView.h"
#import "HBMProfileImageView.h"
#import "HBMChild.h"

@interface HBMNearbyDevicesView ()
@property (nonatomic, strong) NSMutableArray *profileViews;
@end

@implementation HBMNearbyDevicesView

- (void)addProfileView:(HBMProfileImageView *)profileView withTier:(NSUInteger)tier
{
    if (!self.profileViews)
    {
        self.profileViews = @[].mutableCopy;
    }
    
    for (HBMProfileImageView *profile in self.profileViews)
    {
        
        if ([profile.child.childName isEqualToString:profileView.child.childName])
        {
            int index = 0;
            
            for (HBMProfileImageView *profile2 in [self profileViewsForTier:profile.tag])
            {
                [self positionProfileView:profile2 withIndex:index];
                index ++;
            }
            
            profile.tag = tier;
            
            index = 0;
            
            for (HBMProfileImageView *profile2 in [self profileViewsForTier:tier])
            {
                [self positionProfileView:profile2 withIndex:index];
                index ++;
            }
            
            return;
        }
        
    }
    
    profileView.tag = tier;
    [self addSubview:profileView];
    [self.profileViews addObject:profileView];
    
    profileView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    int index = 0;
    for (HBMProfileImageView *profile in [self profileViewsForTier:tier])
    {
        [self positionProfileView:profileView withIndex:index];
        index ++;
    }
}

- (void)positionProfileView:(HBMProfileImageView *)profileView withIndex:(int)index
{
    NSInteger tier = profileView.tag;
    NSInteger spacing = (360 / [self numberOfProfileViewsForTier:tier]);
    NSInteger viewAngle = radiansFromDegrees((spacing * index) + tier * 45);
    NSLog(@"index: %d, spacing: %d, radian angle: %d", index, spacing, viewAngle);
    NSInteger radius = 30 + (40 * tier);
    
    CGPoint thisCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    [UIView animateWithDuration:1 animations:^{
        profileView.center = CGPointMake(thisCenter.x + (radius * cos(viewAngle)),
                                         thisCenter.y + (radius * sin(viewAngle)));
        
    }];
    
}


NSInteger radiansFromDegrees(NSInteger degrees)
{
    return (M_PI * degrees / 180);
}

- (NSArray *)profileViewsForTier:(NSUInteger)tier
{
    NSMutableArray *returnArray = [NSMutableArray array];
    for (HBMProfileImageView *profileView in self.profileViews)
    {
        if (profileView.tag == tier)
        {
            [returnArray addObject:profileView];
        }
    }
    
    return returnArray;
}

- (NSInteger)numberOfProfileViewsForTier:(NSUInteger)tier
{
    return [self profileViewsForTier:tier].count;
}

- (void)clearAll
{
//    for (UIView *view in self.subviews)
//    {
//        [view removeFromSuperview];
//    }
//    
//    self.profileViews = @[].mutableCopy;
}

@end
