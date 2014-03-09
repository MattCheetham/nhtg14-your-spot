//
//  HBMConcentricCircleView.m
//  Your Spot
//
//  Created by Daniel Tomlinson on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "HBMConcentricCircleView.h"

@implementation HBMConcentricCircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        for (NSInteger i = 0; i < 5; i ++) {
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            
            CGRect containmentRect = CGRectInset(frame, 40 * i, 40 * i);
            UIColor *backgroundColor = [UIColor colorWithWhite:0.98 - (0.04 * i) alpha:0.2];
            
            shapeLayer.bounds = containmentRect;
            shapeLayer.position = CGPointMake(CGRectGetMidX(frame),
                                              CGRectGetMidY(frame));
            shapeLayer.fillColor = backgroundColor.CGColor;
            CGMutablePathRef elipsePath = CGPathCreateMutable();
            CGPathAddEllipseInRect(elipsePath, nil, shapeLayer.bounds);
            shapeLayer.path = elipsePath;
            
            [self.layer addSublayer:shapeLayer];
        }
        
    }
    
    return self;
}

@end
