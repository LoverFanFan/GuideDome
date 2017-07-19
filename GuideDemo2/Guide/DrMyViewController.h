
//
//  DrMyViewController.h
//  LemonShow
//
//  Created by 凡凡 on 15-6-22.
//  Copyright (c) 2015年 LemonShow. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyViewController : UIViewController
{

    int                     _pageNumber;
    NSUInteger              _totalNumber;

    UIImageView             *_numberImage;
    BOOL                    _bShowBtn;
    UIButton                *_btn;
    
    UIImageView             *_animationView;
    
    UIImageView             *_iconlogo;
    UIImageView             *_iconcar;
    UIImageView             *_icontext;
    BOOL                    _foranimation;
    
}

@property (nonatomic, strong) UIImageView       *numberImage;
@property (nonatomic, assign) int               pageNumber;
@property (nonatomic, assign) BOOL              bShowBtn;
@property (nonatomic, assign) NSUInteger        totalNum;
@property (nonatomic, strong) UIButton          *btn;
@property (nonatomic, strong) UIImageView       *animationView;
@property (nonatomic, strong) UIImageView       *iconlogo;
@property (nonatomic, strong) UIImageView       *iconcar;
@property (nonatomic, strong) UIImageView       *icontext;
@property (nonatomic, assign) BOOL              foranimation;

-(void)setFrame:(CGRect)frame;

@end
