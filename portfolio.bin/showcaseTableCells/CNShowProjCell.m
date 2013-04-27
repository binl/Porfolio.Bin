//
//  CNShowProjCell.m
//  portfolio.bin
//
//  Created by Lenix Liu on 13-4-25.
//  Copyright (c) 2013年 Bin Liu. All rights reserved.
//

#import "CNShowProjCell.h"

#import <QuartzCore/QuartzCore.h>
#import "CNProjContentViewController.h"

#define CONTENT_WIDTH 280
#define PAGE_PADDING 10


static NSString *kDescKey = @"description";
static NSString *kImageKey = @"image";

@interface CNShowProjCell ()

@end

@implementation CNShowProjCell

@synthesize scrollShowCase, labelTitle, bgView;
@synthesize viewControllers, contentList;

- (void)initCellWithProject:(NSString *)projName{
    NSString *path = [[NSBundle mainBundle] pathForResource:projName ofType:@"plist"];
    self.contentList = [NSArray arrayWithContentsOfFile:path];
    
    self.labelTitle.text = @"Later Note";
    
    // Background setup
    if (self.bgView == NULL) {
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 5, 290, 400)];
        
        [self.bgView setBackgroundColor:[UIColor darkTextColor]];
        [self.bgView setAlpha:0.6];
        self.bgView.layer.cornerRadius = 8;
        self.bgView.layer.masksToBounds = YES;
        [self insertSubview:self.bgView atIndex:0];
    }
    
    NSUInteger numberPages = self.contentList.count;
    
    // view controllers are created lazily
    // in the meantime, load the array with placeholders which will be replaced on demand
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < numberPages; i++)
    {
		[controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    
    // a page is the width of the scroll view
    self.scrollShowCase.pagingEnabled = YES;
    self.scrollShowCase.contentSize =
    CGSizeMake((CONTENT_WIDTH + PAGE_PADDING)* numberPages
               , CGRectGetHeight(self.scrollShowCase.frame));
    self.scrollShowCase.showsHorizontalScrollIndicator = NO;
    self.scrollShowCase.showsVerticalScrollIndicator = NO;
    self.scrollShowCase.scrollsToTop = NO;
    self.scrollShowCase.delegate = self;
    
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    [self loadScrollViewWithPage:2];
}

- (void)loadScrollViewWithPage:(NSUInteger)page
{
    if (page >= 5)
        return;
    
    // replace the placeholder if necessary
    CNProjContentViewController *controller = [self.viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [[CNProjContentViewController alloc]
                      initWithNibName:@"CNProjContentViewController"
                      bundle:nil];
        [self.viewControllers replaceObjectAtIndex:page withObject:controller];
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        CGRect frame;
        frame.origin.x = PAGE_PADDING/2 + (CONTENT_WIDTH + PAGE_PADDING) * page;
        frame.origin.y = 0;
        frame.size.width = CONTENT_WIDTH;
        frame.size.height = 300;
        controller.view.frame = frame;
        
        [self.scrollShowCase addSubview:controller.view];
        
        NSDictionary *numberItem = [self.contentList objectAtIndex:page];
        controller.imageItem.image = [UIImage imageNamed:[numberItem valueForKey:kImageKey]];
        controller.labelDescription.text = [numberItem valueForKey:kDescKey];

    }
}

// at the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // switch the indicator when more than 50% of the previous/next page is visible
    NSUInteger page = floor((self.scrollShowCase.contentOffset.x - CONTENT_WIDTH / 2) / CONTENT_WIDTH) + 1;
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 2];
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    [self loadScrollViewWithPage:page + 2];
    
    // a possible optimization would be to unload the views+controllers which are no longer visible
}

@end
