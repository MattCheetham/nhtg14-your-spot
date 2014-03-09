//
//  HBMImageHeaderCell.h
//  Your Spot
//
//  Created by Matthew Cheetham on 09/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBMImageHeaderCell : UITableViewCell

@property (nonatomic, strong) UIImageView *backgroundImage;
@property (nonatomic, strong) UILabel *placeNameLabel;
@property (nonatomic, strong) UILabel *placeDistanceLabel;

@end
