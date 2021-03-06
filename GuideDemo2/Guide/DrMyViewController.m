
//
//  DrMyViewController.m
//  LemonShow
//
//  Created by 凡凡 on 15-6-22.
//  Copyright (c) 2015年 LemonShow. All rights reserved.
//

#define kScreenWidth [UIScreen mainScreen].bounds.size.width    //屏幕宽度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height  //屏幕高度
#import "DrMyViewController.h"
#import "AppDelegate.h"



@interface MyViewController (PrivateMethod)

-(void)buttonAction:(id)sender;
-(void)ArrowAnimation:(NSTimer *)id;
@end

@implementation MyViewController

@synthesize numberImage = _numberImage;
@synthesize pageNumber = _pageNumber;
@synthesize bShowBtn = _bShowBtn;
@synthesize totalNum = _totalNumber;
@synthesize btn = _btn;
@synthesize animationView = _animationView;
@synthesize iconcar = _iconcar;
@synthesize iconlogo = _iconlogo;
@synthesize icontext = _icontext;
@synthesize foranimation = _foranimation;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _foranimation = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    _numberImage = nil;
    _btn = nil;
    self.icontext = nil;
    self.iconlogo = nil;
    self.iconcar = nil;
    self.animationView = nil;
}

-(void)loadView
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , kScreenWidth, kScreenHeight)];
    backgroundView.backgroundColor = [UIColor colorWithRed:73.0/255.0 green:191.0/255.0 blue:251.0/255.0 alpha:1.0];
    backgroundView.userInteractionEnabled = YES;
    self.view = backgroundView;
    
    if(_foranimation)
        [[UIApplication sharedApplication]setStatusBarHidden:YES];
    else
        [[UIApplication sharedApplication]setStatusBarHidden:NO];

}

-(void)setFrame:(CGRect)frame
{
    self.view.frame = CGRectMake(0,0,frame.size.width, frame.size.height);
    self.view.center = CGPointMake(frame.size.width/2.0, frame.size.height/2.0);
    _numberImage.frame = CGRectMake(0,0,frame.size.width, frame.size.height);
    _numberImage.center = CGPointMake(frame.size.width/2.0, frame.size.height/2.0);
}

-(void)setBShowBtn:(BOOL)bShowBtn
{
    _bShowBtn = bShowBtn;
    if(bShowBtn && _foranimation){
       
        UIButton   *btn = [[UIButton alloc]initWithFrame:self.view.frame];
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];

        return;
    }
    else if(!_foranimation)
    {
        if(!_btn)
        {
            _btn = [[UIButton alloc]initWithFrame:self.view.frame];
            _btn.backgroundColor = [UIColor clearColor];
            [_btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_btn];
 
        }
        _btn.hidden = !bShowBtn;

        return;

    }
    
}

-(void)buttonAction:(id)sender
{
}

@end
