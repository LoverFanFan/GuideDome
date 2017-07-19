
//
//  LSPhoneContentController
//  LemonShow
//
//  Created by 凡凡 on 15-6-23.
//  Copyright (c) 2015年 LemoShow. All rights reserved.
//



#import "DrPhoneContentController.h"
#import "AppDelegate.h"
#import "DrMyViewController.h"


@interface DrPhoneContentController (PrivateMethods)
- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;
- (void)ArrowAnimationPlay:(NSTimer *) id;
@end


@implementation DrPhoneContentController

@synthesize contentList     = _contentList;
@synthesize viewControllers = _viewControllers;
@synthesize pageNum         = _pageNum;
@synthesize scrollView      = _scrollView;
@synthesize pageControl     = _pageControl;
@synthesize banimation      = _banimation;


-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(!self)
        return nil;
   
    self.backgroundColor = [UIColor blackColor];
    UIImageView   *imageview = [[UIImageView alloc]initWithFrame:frame];
   // imageview.image = [UIImage imageNamed:@"main_ad_bg.png"];
    imageview.backgroundColor = [UIColor colorWithRed:0xf4/255.0 green:0xf4/255.0 blue:0xf4/255.0 alpha:1.0];
    [self addSubview:imageview];
    self.banimation = YES;
    _show = NO;
    _pageControlUsed = YES;
    return self;
}

- (void)dealloc
{
    self.contentList = nil;
    
    self.viewControllers = nil;
    
    if(self.scrollView)
        [self.scrollView removeFromSuperview];
    self.scrollView = nil;
    self.pageControl = nil;
}

- (UIView *)view
{
    return self.scrollView;
}

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= _pageNum)
    {
        if(page > _pageNum && _banimation)
        {
            //[[DrAppDelegate DrAppDelegate]switchViewControllerWithTag:enViewControllerAnimation toViewController:enViewControllerMainView tag:0];
        
        }
        return;
    }
    // replace the placeholder if necessary
    if(!_viewControllers || [_viewControllers count] == 0)
        return;
    
    MyViewController *controller = [_viewControllers objectAtIndex:page];

    if ((NSNull *)controller == [NSNull null]){
        
        controller = [[MyViewController alloc] init];
        controller.foranimation = _banimation;
        [controller setFrame:self.frame];
        controller.totalNum = _pageNum;
        controller.pageNumber = page;
        if(page == _pageNum -1 && _banimation)
            controller.bShowBtn = YES;
        else
            controller.bShowBtn = _show;
        [_viewControllers replaceObjectAtIndex:page withObject:controller];
    }
    
    if (controller.view.superview == nil)
    {
        CGRect frame = _scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [_scrollView addSubview:controller.view];
        
        if(_banimation){
           
            controller.numberImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_1.jpg",page + 1]];
            if(page == _pageNum - 1)
                controller.foranimation = YES;
            
        }
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)sender{

    if (_pageControlUsed){
        return;
    }
	
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = page;
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    _pageControlUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    _pageControlUsed = NO;
}

- (void) setPageNum:(NSUInteger)pageNum{
    
    _pageNum = pageNum;
    
    NSString   *path = nil;
    
    if(_pageNum == 3 && _banimation){
        
        path = [[NSBundle mainBundle] pathForResource:@"content_iPhone_2" ofType:@"plist"];
    }
    else{
        path = [[NSBundle mainBundle] pathForResource:@"content_iPhone_5" ofType:@"plist"];
    }
    
    self.contentList = [NSArray arrayWithContentsOfFile:path];

    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < _pageNum; i++)
    {
		[controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    
    // a page is the width of the scroll view
    _scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    _scrollView.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * _pageNum, self.frame.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    if(_pageControlUsed){
        
        if(!_banimation){
            
            _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 12)];
            _pageControl.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height - 6);
        }
        else{
            
            _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
            _pageControl.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height - 40);
        }
        _pageControl.numberOfPages = _pageNum;
        _pageControl.currentPage = 0;
        _pageControl.backgroundColor = [UIColor redColor];
        
        [self addSubview:_pageControl];
 
    }
    
    [self loadScrollViewWithPage:0];

}

- (void)showBtn:(BOOL)show{
    
    _show = show;
    
    for(MyViewController *each in _viewControllers){
        
        if((NSNull *)each != [NSNull null])
            each.bShowBtn = show;
    }
}


@end
