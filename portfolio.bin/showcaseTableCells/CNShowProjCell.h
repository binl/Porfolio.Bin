//
//  CNShowProjCell.h
//  portfolio.bin
//
//  Created by Lenix Liu on 13-4-25.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNShowProjCell : UITableViewCell
<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollShowCase;
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) UIView *bgView;

@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) NSArray *contentList;

- (void)initCellWithProject:(NSString *)projName;

@end
