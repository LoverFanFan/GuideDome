//
//  DrPrefs.m
//  LemonShow
//
//  Created by 凡凡 on 15-6-23.
//  Copyright (c) 2015年 LemonShow. All rights reserved.
//

#import "DrPrefs.h"
#import "DrPrefs+IntroInfo.h"

@interface DrPrefs ()

/**
 *  获取本地保存的app版本号
 *
 *  @return 版本号
 */
- (NSString *)localAppVersion;
/**
 *  将app版本号保存到本地
 *
 *  @param tAppVersion 版本号
 */
- (void)setLocalAppVersion:(NSString *)tAppVersion;

/**
 是否第一次安装运行
 */
- (BOOL)isFirstRunOnNewInstall;
/**
 是否升级后第一次运行
 */
- (BOOL)isFirstRunOnUpgrade;

//与本地记录的版本比，当前安装的版本是不是新版本
//- (BOOL)isNewVersion:(NSString*) localVersion;


@end

static DrPrefs *shareInstance = nil;
@implementation DrPrefs
@synthesize isFirstRunApp;
@synthesize isUpdateFirstRunApp;


/**
 *  获取实例
 *
 *  @return 单例
 */
+ (DrPrefs *)shareInstance{
    @synchronized(self) {
        if (!shareInstance) {
            shareInstance = [[DrPrefs alloc] init];
        }
    }
    return shareInstance;
}


/**
 *  获取当前APP版本号
 *
 *  @return 版本号
 */
+ (NSString*)appVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}


/**
 *  app启动需处理的业务
 */
- (void)appStart{
    
    // 首次安装运行
    if ([self isFirstRunOnNewInstall]) {
        isFirstRunApp = YES;
        
    }
    
    // 版本更新后首次运行
    if ([self isFirstRunOnUpgrade]) {
        isUpdateFirstRunApp = YES;
    }

    
    // 更新app版本号
    [self setLocalAppVersion:[DrPrefs appVersion]];

    
}


/**
 *  获取本地保存的app版本号
 *
 *  @return 版本号
 */
- (NSString *)localAppVersion
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"appVersion"];
}

/**
 *  将app版本号保存到本地
 *
 *  @param tAppVersion 版本号
 */
- (void)setLocalAppVersion:(NSString *)tAppVersion
{
    if (tAppVersion && [tAppVersion length] > 0) {
        
        [[NSUserDefaults standardUserDefaults] setObject:tAppVersion forKey:@"appVersion"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

/**
 是否第一次安装运行
 */
- (BOOL)isFirstRunOnNewInstall
{
    if (![self localAppVersion] || [[self localAppVersion] length] == 0) {
        
        return YES;
        
    }
    return NO;
}

/**
 是否升级后第一次运行
 */
- (BOOL)isFirstRunOnUpgrade{
    NSString *localAppVersion = [self localAppVersion];
    NSString *curAppVersion = [DrPrefs appVersion];
    if (localAppVersion) {
        BOOL isNew = NO;
        switch ([localAppVersion compare:curAppVersion options:NSNumericSearch]) {
            case NSOrderedAscending:
                isNew = YES;
                break;
            case NSOrderedSame:
                isNew = NO;
                break;
            case NSOrderedDescending:
                isNew = NO;
                break;
            default:
                break;
        }
        return isNew;
    }
    return NO;
}

@end
