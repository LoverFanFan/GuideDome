//
//  DrPrefs.h
//  LemonShow
//
//  Created by 凡凡 on 15-6-23.
//  Copyright (c) 2015年 LemonShow. All rights reserved.
//

/**
 *  用于处理app启动时的各种初始化
 */

#import <Foundation/Foundation.h>

@interface DrPrefs : NSObject

@property (nonatomic) BOOL isFirstRunApp;// 首次安装运行
@property (nonatomic) BOOL isUpdateFirstRunApp;// 版本更新后首次运行


/**
 *  获取实例
 *
 *  @return 单例
 */
+ (DrPrefs *)shareInstance;

/**
 *  获取当前APP版本号
 *
 *  @return 版本号
 */
+ (NSString*)appVersion;

/**
 *  app启动需处理的业务
 */
- (void)appStart;




@end
