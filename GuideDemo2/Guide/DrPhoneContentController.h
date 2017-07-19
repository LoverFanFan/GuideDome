
//
//  LSPhoneContentController
//  LemonShow
//
//  Created by 凡凡 on 15-6-23.
//  Copyright (c) 2015年 LemoShow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface DrPhoneContentController : UIView <UIScrollViewDelegate>
{   
    UIScrollView                        *_scrollView;
	UIPageControl                       *_pageControl;
    NSMutableArray                      *_viewControllers;
    
    BOOL                                _pageControlUsed;
    
    NSArray                             *_contentList;
    
    NSUInteger                          _pageNum;
    BOOL                                _show;
    BOOL                                _banimation;
}

@property (nonatomic, strong) UIScrollView          *scrollView;
@property (nonatomic, strong) UIPageControl         *pageControl;

@property (nonatomic, strong) NSMutableArray        *viewControllers;

@property (nonatomic, strong) NSArray               *contentList;

@property (nonatomic, assign) NSUInteger            pageNum;
@property (nonatomic, assign) BOOL                  banimation;


-(void) showBtn:(BOOL)show;

@end
