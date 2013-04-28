//
//  CNNavHeaderView.m
//  portfolio.bin
//
//  Created by Lenix Liu on 13-4-27.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import "CNNavHeaderView.h"

@implementation CNNavHeaderView

//@synthesize lblHiddenCue;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        UIView *bgView = [[UIView alloc] initWithFrame:frame];
        
        [bgView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        [bgView setAlpha:1];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:frame];
        [titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:26]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        titleLabel.text = @"Portfolio";
        
        //self.lblHiddenCue = titleLabel;
        
        [self addSubview: bgView];
        [self addSubview: titleLabel];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
