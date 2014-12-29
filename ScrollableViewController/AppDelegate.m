//
//  AppDelegate.m
//  ScrollableViewController
//
//  Created by zx on 12/29/14.
//  Copyright (c) 2014 zx. All rights reserved.
//

#import "AppDelegate.h"
#import "ScrollableViewController.h"
#import "ViewController.h"

@interface AppDelegate ()<UIScrollViewDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *vc1 = [ViewController new];
    vc1.title = @"vc1";
    ViewController *vc2 = [ViewController new];
    vc2.title = @"vc2";
    ScrollableViewController *vc = [[ScrollableViewController alloc]initWithViewControllers:@[vc1,vc2]];
    vc.title = @"ScrollableViewController";
    vc.scrollViewDelegate = self;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    window.rootViewController = nav;
    [window makeKeyAndVisible];
    self.window = window;
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%@",scrollView);
}

@end
