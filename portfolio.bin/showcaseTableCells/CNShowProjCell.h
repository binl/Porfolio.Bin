//
//  CNShowProjCell.h
//  portfolio.bin
//
//  Created by Lenix Liu on 13-4-25.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNViewController.h"

@interface CNShowProjCell : UITableViewCell
<UIScrollViewDelegate>

@property (strong, nonatomic) CNViewController *mainView;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollShowCase;
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnAppStore;
@property (strong, nonatomic) IBOutlet UIView *bgView;

@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) NSArray *contentList;

@property (strong, nonatomic) NSString *_app_url;

- (void)initCellWithProject:(NSString *)projName startAtDir:(NSString *)subDir;

- (IBAction)openInAppStore:(id)sender;
@end
