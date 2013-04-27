//
//  CNViewController.h
//  portfolio.bin
//
//  Created by Lenix Liu on 13-4-25.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableShowcase;
@property (strong, nonatomic) IBOutlet UIImageView *imageBg;

@property (strong, nonatomic) IBOutlet UIView *viewShellContainer;
@property (strong, nonatomic) IBOutlet UITextField *txtShellInput;
@property (strong, nonatomic) IBOutlet UIView *viewShellOverlay;
@property (strong, nonatomic) IBOutlet UILabel *lblShellOutput;

-(void)displayShell;
-(void)makeShellShow:(BOOL)is_show;

-(IBAction)dismissShell:(id)sender;

@end
