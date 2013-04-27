//
//  CNProjContentViewController.m
//  portfolio.bin
//
//  Created by Lenix Liu on 13-4-26.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import "CNProjContentViewController.h"

@interface CNProjContentViewController ()

@end

@implementation CNProjContentViewController

@synthesize imageItem, labelDescription;

// load the view nib and initialize the pageNumber ivar
- (id)initWithPageNumber:(NSUInteger)page
{
    if (self = [super initWithNibName:@"CNProjContentViewController" bundle:nil])
    {
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
