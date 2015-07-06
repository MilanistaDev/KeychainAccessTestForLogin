//
//  AppDelegate.m
//  LoginKeychain
//
//  Created by SDT-B003 on 2015/06/30.
//  Copyright (c) 2015年 Takuya ASO. All rights reserved.
//

/*
 Special Thanks
 LUKeychainAccess
 Copyright 2012-2013 SCVNGR, Inc D.B.A. LevelUp.
 Released under the MIT license
 https://github.com/TheLevelUp/LUKeychainAccess
 */

#import "AppDelegate.h"
#import "LUKeychainAccess.h"    // 追加

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIViewController *initialViewController;
    
    // ALREADY_LOGIN の Key に YES が入っているかどうか
    BOOL key = [[LUKeychainAccess standardKeychainAccess] boolForKey:@"ALREADYLOGIN"];
    NSLog(@"KEYCHAIN= %d", key);
    
    // 一回ログイン画面に飛んで，自動ログインしますか？アラートを出して確認とるほうがいいかも知れません。
    // 今回は自動ログイン，ログイン画面をスキップしてメインコンテンツ画面へ
    if (key == YES) {
        
        // ストーリーボードを取得，遷移先の Viewは？，initialViewController(最初に開く画面) に設定
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"MainContent"];
        initialViewController = vc;
        
    } else {
    // なければログイン画面に飛ばしてログインしてね
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
        initialViewController = vc;
    }
    
    self.window.rootViewController = initialViewController;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




@end
