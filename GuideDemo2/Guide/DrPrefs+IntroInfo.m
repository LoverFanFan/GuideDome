//
//  DrPrefs+IntroInfo.m
//  LemonShow
//
//  Created by 凡凡 on 15-6-23.
//  Copyright (c) 2015年 LemonShow. All rights reserved.
//

#import "DrPrefs+IntroInfo.h"

@implementation DrPrefs (IntroInfo)

/**
 *  新手引导功能相关
 *
 */

- (NSString *)introVersion
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"introVersion"];
}

- (void)setIntroVersion:(NSString *)aIntroVersion
{
    if (aIntroVersion && [aIntroVersion length] > 0) {
        [[NSUserDefaults standardUserDefaults]  setObject:aIntroVersion forKey:@"introVersion"];
        [[NSUserDefaults standardUserDefaults]  synchronize];
    }
}

/**
 新手引导是否完成
 */
- (BOOL)isIntroFinished{
    if ([self introVersion]) {
        BOOL isFinished = NO;
        switch ([[self introVersion] compare:[DrPrefs appVersion] options:NSNumericSearch]) {
            case NSOrderedAscending:
                isFinished = NO;
                break;
            case NSOrderedSame:
                isFinished = YES;
                break;
            case NSOrderedDescending:
                isFinished = YES;
                break;
            default:
                break;
        }
        return isFinished;
    }
    
    return NO;
}
/**
 设置新手引导已完成
 */
- (void)introFinished{
    // 设置为新版本号
    self.introVersion = [DrPrefs appVersion];
}

@end
