//
//  LSIntroductionViewController
//  LemonShow
//
//  Created by 凡凡 on 15-6-23.
//  Copyright (c) 2015年 LemonShow. All rights reserved.
//

/**
 *  新手指引功能
 */

#import <UIKit/UIKit.h>


@protocol DrIntroductionViewDelegate <NSObject>

- (void)finishIntro;

@end

@interface DrIntroductionViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) id <DrIntroductionViewDelegate> introDelegate;

@end
