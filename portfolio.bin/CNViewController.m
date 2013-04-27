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
#import "CNNavHeaderView.h"
#import "CNExtHeaderVIew.h"
/* Libs */
#import "UIImage+StackBlur.h"


#define SECTION_HDR_WIDTH 320
#define SECTION_HDR_HEIGHT 40

#define HELP_MSG @"How to use shell in TinyFS?\n\
- In short, like any other shell!\n\
\n\
* \"cd\" to navigate through folders\n\
* \"ls\" to list all files in the folder\n\
* \"man\" to display this help msg\n\
* swipe to right or \"quit\" to leave shell"

static const CGFloat kRevealDeltaY = -180.0f;

@interface CNViewController () {
    UIImage *_original_bg;
    UIImage *_transition_1_bg;
    UIImage *_transition_2_bg;
    UIImage *_blurred_bg;
    
    NSString *_currentShow;
    
    CNExtHeaderVIew *_extHdr;
}
@end

@implementation CNViewController

@synthesize tableShowcase, viewShellContainer, imageBg;
@synthesize txtShellInput;
@synthesize viewShellOverlay, lblShellOutput;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set up the headerView
    CGRect frame = CGRectMake(0,-480,320,480);
    _extHdr = [[CNExtHeaderVIew alloc] initWithFrame:frame];
    [self.tableShowcase addSubview:_extHdr];
    
    _original_bg=[UIImage imageNamed:@"portrait_bg.jpg"];
    _transition_1_bg = [_original_bg stackBlur:4];
    _transition_2_bg = [_original_bg stackBlur:8];
    _blurred_bg = [_original_bg stackBlur:12];
    [self.imageBg setImage:_original_bg];
    
    _currentShow = @"coverpage";
}


- (void)viewWillAppear:(BOOL)animated {
    self.lblShellOutput.text = HELP_MSG;
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
    CNNavHeaderView *hdrView = [[CNNavHeaderView alloc] initWithFrame:
                       CGRectMake(0, 0, SECTION_HDR_WIDTH, SECTION_HDR_HEIGHT)];
    
    UIButton *btnShell = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [btnShell addTarget:self action:@selector(displayShell) forControlEvents:UIControlEventTouchUpInside];
    btnShell.frame = CGRectMake(280, 0, 40, 40);
    
    [hdrView addSubview:btnShell];
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
        [(CNShowProjCell *)cell initCellWithProject:_currentShow];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - scrolling behavior
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.tableShowcase]==YES) {
        if (scrollView.contentOffset.y > kRevealDeltaY
            && scrollView.contentOffset.y < 0.0f) {
            [_extHdr revealSecret:NO];
        }
        else if (scrollView.contentOffset.y < kRevealDeltaY) {
            [_extHdr revealSecret:YES];
        }
        else if (scrollView.contentOffset.y < 5.0f) {
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

#pragma mark - shell actions

-(void)displayShell {
    [self makeShellShow:YES];
    [self.txtShellInput becomeFirstResponder];
}

-(IBAction)dismissShell:(id)sender {
    [self makeShellShow:NO];
    [self.txtShellInput resignFirstResponder];
    [self.viewShellOverlay setHidden:YES];
}

-(void)makeShellShow:(BOOL)is_show {
    CGRect tmpFrame = self.viewShellContainer.frame;
    if (is_show && tmpFrame.origin.x != 0) {
        tmpFrame.origin.x = 0;
        [UIView animateWithDuration:0.5 animations:^{
            self.viewShellContainer.frame = tmpFrame;
        }];
    }
    else if (!is_show && tmpFrame.origin.x == 0){
        tmpFrame.origin.x = 320;
        [UIView animateWithDuration:0.5 animations:^{
            self.viewShellContainer.frame = tmpFrame;
        }];
    }
}

#pragma mark - textfield delegates
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.tableShowcase setContentOffset:CGPointMake(0, 440) animated:YES];
    [self.viewShellOverlay setHidden:NO];
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text length] == 0) {
        [self dismissShell:nil];
        return NO;
    }
    
    [self parseline:textField.text];
    textField.text = @"";
    //_currentShow = textField.text;
    //[self dismissShell:nil];
    return YES;
}


#pragma mark - shell parseline
-(void)parseline:(NSString *)input {
    NSString *path = [[NSBundle mainBundle] pathForResource:_currentShow ofType:@"plist"];
    NSDictionary *currentFolderInfo = [NSDictionary dictionaryWithContentsOfFile:path];
    
    BOOL hide_contact = YES;
    NSArray *inputParts = [input componentsSeparatedByString:@" "];
    if (inputParts.count > 2 || inputParts.count == 0) {
        return;
    }
    NSString *command = [inputParts objectAtIndex:0];
    if ([command isEqualToString:@"cd"]) {
        if (inputParts.count != 2) {
            return;
        }
        
        NSString *targetFolder = [inputParts objectAtIndex:1];
        if ([targetFolder isEqualToString:@".."]) {
            NSString *parentDir = [currentFolderInfo objectForKey:@"parentDir"];
            if (parentDir == NULL) {
                self.lblShellOutput.text = @"We are in Root Directory already";
                return;
            }
            _currentShow = parentDir;
            [self updateContent];
        }
        else {
            NSDictionary *childDirs = [currentFolderInfo objectForKey:@"dirInfo"];
            NSString *childDir = [childDirs objectForKey:targetFolder];
            if (childDir == NULL) {
                self.lblShellOutput.text = @"Directory not found";
                return;
            }
            _currentShow = childDir;
            [self updateContent];
        }
    }
    else if ([command isEqualToString:@"ls"]) {
        NSArray *list = [[currentFolderInfo objectForKey:@"dirInfo"] allKeys];
        if (list.count == 0) {
            self.lblShellOutput.text = @"Directory Empty";
        }
        else {
            NSMutableString *lsOutput = [NSMutableString stringWithString:@"Listing Files:\n"];
            
            if (inputParts.count == 2 &&
                [[inputParts objectAtIndex:1] isEqualToString:@"-a"]) {
                hide_contact = NO;
            }
            
            for (NSString *key in list) {
                if ([key isEqualToString:@".contact_me"] && hide_contact) {
                    continue;
                }
                [lsOutput appendFormat:@"\t\t-%@\n",key];
            }
            
            self.lblShellOutput.text = lsOutput;
        }
    }
    else if ([command isEqualToString:@"man"]) {
        self.lblShellOutput.text = HELP_MSG;
    }
    else if ([command isEqualToString:@"quit"]) {
        [self dismissShell:nil];
    }
    else
        self.lblShellOutput.text = @"Command not found, use \"man\" to learn more";
    return;
}

-(void)updateContent{
    [self.tableShowcase reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    
    [self.txtShellInput resignFirstResponder];
    
    [self.viewShellOverlay setHidden:YES];
}

@end
