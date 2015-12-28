//
//  MenuTableViewCell.m
//  LacarSliderView
//
//  Created by Lanseer on 15/11/10.
//  Copyright (c) 2015年 Lacar. All rights reserved.
//

#import "MenuTableViewCell.h"
#import <pop/POP.h>
@implementation MenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (self.selected) {
        
       
    } else {
        
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(4, 4)];
        scaleAnimation.springBounciness = 20.f;
        [self pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


@end
