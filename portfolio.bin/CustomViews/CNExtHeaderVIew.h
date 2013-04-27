//
//  CNExtHeaderVIew.h
//  portfolio.bin
//
//  Created by Lenix Liu on 13-4-27.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNExtHeaderVIew : UIView

@property (strong, nonatomic) UILabel *lblHiddenCue;

-(void)revealSecret:(BOOL)is_show;

@end
