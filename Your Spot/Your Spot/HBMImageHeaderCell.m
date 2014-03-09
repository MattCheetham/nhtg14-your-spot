//
//  HBMImageHeaderCell.m
//  Your Spot
//
//  Created by Matthew Cheetham on 09/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "HBMImageHeaderCell.h"

@implementation HBMImageHeaderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundImage = [[UIImageView alloc] init];
        self.backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.backgroundImage];
        
        self.placeNameLabel = [UILabel new];
        self.placeNameLabel.backgroundColor = [UIColor clearColor];
        self.placeNameLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        self.placeNameLabel.layer.borderWidth = 3;
        self.placeNameLabel.textColor = [UIColor whiteColor];
        self.placeNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30];
        self.placeNameLabel.textAlignment = NSTextAlignmentCenter;
        self.placeNameLabel.adjustsFontSizeToFitWidth = YES;
        
        self.placeDistanceLabel = [UILabel new];
        self.placeDistanceLabel.textColor = [UIColor whiteColor];
        self.placeDistanceLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
        self.placeDistanceLabel.textAlignment = NSTextAlignmentCenter;
        self.placeDistanceLabel.adjustsFontSizeToFitWidth = YES;

        
        [self.contentView addSubview:self.placeNameLabel];
        [self.contentView addSubview:self.placeDistanceLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backgroundImage.frame = self.bounds;
    self.placeNameLabel.frame = CGRectMake(0, 0, 200, 60);
    self.placeNameLabel.center = self.contentView.center;
    
    self.placeDistanceLabel.center = self.contentView.center;
    self.placeDistanceLabel.frame = CGRectMake(self.placeDistanceLabel.frame.origin.x, 150, 200, 60);

}

@end
