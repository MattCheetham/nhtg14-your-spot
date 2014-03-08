//
//  HBMProfileImageView.m
//  Your Spot
//
//  Created by Daniel Tomlinson on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "HBMProfileImageView.h"

@interface HBMProfileImageView ()
@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation HBMProfileImageView

- (instancetype)initWithImage:(UIImage *)image frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:imageView];
        
        self.imageView = imageView;
        
        self.imageView.frame = self.bounds;
        self.layer.cornerRadius = CGRectGetWidth(frame) / 2;
        self.clipsToBounds = YES;
        self.borderColor = [UIColor blackColor];
        self.layer.borderWidth = 3.0f;
    }
    
    return self;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

@end
