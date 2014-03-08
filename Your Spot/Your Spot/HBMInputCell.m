//
//  MDCInputCell.m
//  DeveloperMenu
//
//  Created by Matthew Cheetham on 21/02/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "HBMInputCell.h"

@implementation HBMInputCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textField = [UITextField new];
        [self.contentView addSubview:self.textField];
        
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
        
    CGRect textFieldFrame = self.contentView.frame;
    textFieldFrame.origin.x += 15;
    textFieldFrame.size.width -= 30;
    self.textField.frame = textFieldFrame;
}
@end
