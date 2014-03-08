//
//  HBMProfileImageView.h
//  Your Spot
//
//  Created by Daniel Tomlinson on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBMProfileImageView : UIView

@property (nonatomic, retain) UIColor *borderColor;

- (instancetype)initWithImage:(UIImage *)image frame:(CGRect)frame;

- (void)setImage:(UIImage *)image;

@end
