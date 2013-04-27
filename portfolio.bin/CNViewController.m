//
//  CNViewController.m
//  portfolio.bin
//
//  Created by Lenix Liu on 13-4-25.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import "CNViewController.h"

#import "CNShowCoverCell.h"
#import "CNShowProjCell.h"

/* Libs */
#import "UIImage+StackBlur.h"

#define SECTION_HDR_WIDTH 320
#define SECTION_HDR_HEIGHT 40

@interface CNViewController () {
    UIImage *_original_bg;
    UIImage *_transition_1_bg;
    UIImage *_transition_2_bg;
    UIImage *_blurred_bg;
}
@end

@implementation CNViewController

@synthesize tableShowcase;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Set up the headerView
    CGRect frame = CGRectMake(0,-480,320,480);
    UIView *headerView = [[UIView alloc]initWithFrame:frame];
    headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    headerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];

    UILabel *labelPull = [[UILabel alloc]
                          initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f
                                                   ,frame.size.width, 20.0f )];
    [labelPull setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:15]];
    [labelPull setTextAlignment:NSTextAlignmentCenter];
    [labelPull setBackgroundColor:[UIColor clearColor]];
    [labelPull setTextColor:[UIColor darkTextColor]];
    [labelPull setShadowColor:[UIColor lightGrayColor]];
    [labelPull setShadowOffset:CGSizeMake(-1, 1)];
    labelPull.text = @"Pull to reveal my gift :-)";
    
    [headerView addSubview:labelPull];
    
    [self.tableShowcase addSubview:headerView];
    
    _original_bg=[UIImage imageNamed:@"portrait_bg.jpg"];
    _transition_1_bg = [_original_bg stackBlur:4];
    _transition_2_bg = [_original_bg stackBlur:8];
    _blurred_bg = [_original_bg stackBlur:12];
    [self.imageBg setImage:_original_bg];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView stuff

/* Section Related */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //CNShowHeaderView *hdrView = [[CNShowHeaderView alloc] init];
    UIView *hdrView = [[UIView alloc] initWithFrame:
                       CGRectMake(0, 0, SECTION_HDR_WIDTH, SECTION_HDR_HEIGHT)];
    [hdrView setBackgroundColor:[UIColor clearColor]];
    
    UIView *bgView = [[UIView alloc] initWithFrame:
                      CGRectMake(0, 0, SECTION_HDR_WIDTH, SECTION_HDR_HEIGHT)];
    
    [bgView setBackgroundColor:[UIColor darkTextColor]];
    [bgView setAlpha:0.5];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:
                           CGRectMake(0, 0, SECTION_HDR_WIDTH, SECTION_HDR_HEIGHT)];
    [titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:26]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    titleLabel.text = @"Portfolio";
    
    [hdrView addSubview: bgView];
    [hdrView addSubview: titleLabel];
    
    return hdrView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != 0) {
        return 420;
    }
    return 440;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CNShowCoverCell";
    
    if (indexPath.row == 0) {
        cellIdentifier = @"CNShowCoverCell";
    }
    else {
        cellIdentifier = @"CNShowProjCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:nil options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    if (indexPath.row == 0) {
        [(CNShowCoverCell *)cell initCell];
    }
    else {
        [(CNShowProjCell *)cell initCellWithProject:@"later_note"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - scrolling behavior
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.tableShowcase]==YES) {
        if (scrollView.contentOffset.y < 5.0f) {
            [self.imageBg setImage:_original_bg];
        }
        else if(scrollView.contentOffset.y < 15.0f){
            [self.imageBg setImage:_transition_1_bg];
        }
        else if(scrollView.contentOffset.y < 30.0f){
            [self.imageBg setImage:_transition_2_bg];
        }
        else {
            [self.imageBg setImage:_blurred_bg];
        }
    }
}

@end
