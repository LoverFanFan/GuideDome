//
//  AppDelegate.m
//  GuideDemo2
//
//  Created by wqf on 2017/7/19.
//  Copyright © 2017年 didicat. All rights reserved.
//

#import "AppDelegate.h"
#import "DrIntroductionViewController.h"
#import "DrPrefs.h"
#import "DrPrefs+IntroInfo.h"

@interface AppDelegate ()<DrIntroductionViewDelegate>

@property (nonatomic, strong) DrIntroductionViewController *introController;// 新手指引
@property (nonatomic, strong) UIStoryboard  *storyboard;

@end

@implementation AppDelegate
@synthesize introController;
@synthesize storyboard;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    storyboard      = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    [self showIntroduction];
    
    return YES;
}

- (void)showIntroduction{
    
    if (NO == [[DrPrefs shareInstance] isIntroFinished]) {// 新手指引是否已显示完毕
        // 显示新手指引 DrIntroductionViewControlle
        introController = [[DrIntroductionViewController alloc] init];
        introController.introDelegate = self;
        introController.view.frame = CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.window.rootViewController = introController;
    }else{
        self.window.rootViewController = [storyboard instantiateInitialViewController];
        [self.window makeKeyAndVisible];
    }
}

/**
 *  新手指引显示完毕，进入主页
 */
- (void)finishIntro{
    
    [introController.view removeFromSuperview];
    // 显示主页面
    self.window.rootViewController = [storyboard instantiateInitialViewController];
    [self.window makeKeyAndVisible];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
