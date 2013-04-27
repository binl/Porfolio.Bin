//
//  CNViewController.h
//  portfolio.bin
//
//  Created by Lenix Liu on 13-4-25.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableShowcase;
@property (strong, nonatomic) IBOutlet UIImageView *imageBg;

@end
