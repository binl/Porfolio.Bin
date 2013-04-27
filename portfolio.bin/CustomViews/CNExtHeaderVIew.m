//
//  CNExtHeaderVIew.m
//  portfolio.bin
//
//  Created by Lenix Liu on 13-4-27.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import "CNExtHeaderVIew.h"

@implementation CNExtHeaderVIew

@synthesize lblHiddenCue;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
         self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        UILabel *labelPull = [[UILabel alloc]
                              initWithFrame:CGRectMake(0.0f, frame.size.height - 58.0f
                                                       ,frame.size.width, 40.0f )];
        [labelPull setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:15]];
        [labelPull setTextAlignment:NSTextAlignmentCenter];
        [labelPull setBackgroundColor:[UIColor clearColor]];
        [labelPull setTextColor:[UIColor darkTextColor]];
        [labelPull setShadowColor:[UIColor lightGrayColor]];
        [labelPull setShadowOffset:CGSizeMake(-1, 1)];
        [labelPull setNumberOfLines:0];
        labelPull.text = @"Pull HARD to reveal a clue :-)";
        
        self.lblHiddenCue = labelPull;
        
        //[self addSubview:bgView];
        [self addSubview:self.lblHiddenCue];
    }
    return self;
}

-(void)revealSecret:(BOOL)is_show {
    if (is_show) {
        self.lblHiddenCue.text = @"WOW, you really tried hard, Well then~\nThe \"ls\" command could use an option!";
    }
    else {
        self.lblHiddenCue.text = @"Pull HARD to reveal a clue :-)";
    }
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
