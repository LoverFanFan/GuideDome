//
//  LSIntroductionViewController
//  LemonShow
//
//  Created by 凡凡 on 15-6-23.
//  Copyright (c) 2015年 LemoShow. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width    //屏幕宽度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height  //屏幕高度

#import "DrIntroductionViewController.h"
#import "AppDelegate.h"
#import "DrPrefs+IntroInfo.h"

#define PAGE_NUM 3

@interface DrIntroductionViewController ()

@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *enterButton;

- (IBAction)finishedShowIntoduction:(id)sender;

- (void)prepareScrollView;

- (void)prepareEnterButton;

@end

@implementation DrIntroductionViewController
@synthesize introDelegate;
@synthesize myScrollView;
@synthesize pageControl;
@synthesize enterButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    [self prepareScrollView];
    [self prepareEnterButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
 
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)prepareScrollView{
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    myScrollView.contentSize= CGSizeMake(kScreenWidth * PAGE_NUM, kScreenHeight);
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = NO;
    myScrollView.scrollEnabled = YES;
    myScrollView.pagingEnabled = YES;
    myScrollView.directionalLockEnabled = YES;
    myScrollView.delegate = self;
    [self.view addSubview:myScrollView];
    
   
        
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    pageControl.center = CGPointMake(kScreenWidth/2.0, kScreenHeight - 20);
    
    pageControl.numberOfPages = PAGE_NUM;
    pageControl.currentPage = 0;
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.hidden = YES;
    [self.view addSubview:pageControl];

    
    for (NSInteger i = 1; i <= PAGE_NUM; i++) {
        UIImage *image = nil;
        image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%ld.jpg", (long)i]];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        [imageView setFrame:CGRectMake((i-1)*(kScreenWidth), 0, kScreenWidth, kScreenHeight)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.tag = 1000 + i;
        [myScrollView addSubview:imageView];
    }
    
    
}

- (void)prepareEnterButton{
    
    enterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [enterButton addTarget:self action:@selector(finishedShowIntoduction:)
          forControlEvents:UIControlEventTouchUpInside];
    
    if (PAGE_NUM == 1)
        enterButton.hidden = NO;
    else
        enterButton.hidden = YES;
    
    [self.view addSubview:enterButton];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    float offsetWidth = scrollView.contentOffset.x;
    NSInteger index = offsetWidth/kScreenWidth + 1;
    
    pageControl.currentPage = index - 1;
    if (pageControl.currentPage == -1) {
        pageControl.currentPage = 0;
    }
    
    //到最后一个
    if (index == PAGE_NUM) {
        enterButton.hidden = NO;
    }
    else{
        enterButton.hidden = YES;
    }
}




- (void)finishedShowIntoduction:(id)sender {

    [[DrPrefs shareInstance] introFinished];//置状态
   
    // 先加载首页再执行动画
    if (self.introDelegate && [self.introDelegate respondsToSelector:@selector(finishIntro)]) {
        [self.introDelegate finishIntro];
    }

}


@end
