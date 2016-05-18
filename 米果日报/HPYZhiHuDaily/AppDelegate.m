//
//  AppDelegate.m
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/5.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "HomeViewModel.h"
#import "LeftMenuViewController.h"


@interface AppDelegate ()

@property(strong,nonatomic) UIImageView *launchImaViewO;
@property(strong,nonatomic) UIImageView *launchImaViewT;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:kScreenBounds];
    self.window.backgroundColor = [UIColor whiteColor];
    LeftMenuViewController *leftMenuVC = [[LeftMenuViewController alloc] initWithNibName:@"LeftMenuViewController" bundle:[NSBundle mainBundle]];
    HomeViewController *homeVC = [[HomeViewController alloc] initWithViewModel:[HomeViewModel new]];
    _mainVC = [[MainViewController alloc] initWithLeftMenuViewController:leftMenuVC andHomeViewController:homeVC];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_mainVC];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    navigationController.navigationBarHidden = YES;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setLauchView];
    return YES;
}

- (void)setLauchView {
    _launchImaViewT = [[UIImageView alloc] initWithFrame:kScreenBounds];
    _launchImaViewT.contentMode = UIViewContentModeScaleAspectFill;
    [self.window addSubview:_launchImaViewT];
    
    _launchImaViewO = [[UIImageView alloc] initWithFrame:kScreenBounds];
    _launchImaViewO.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"migoorb" ofType:@"png"]];
    [self.window addSubview:_launchImaViewO];
    
    [HttpOperation getRequestWithURL:@"start-image/720*1184" parameters:nil success:^(id responseObject) {
        [_launchImaViewT sd_setImageWithURL:[NSURL URLWithString:responseObject[@"img"]]];
        [UIView animateWithDuration:2.0f animations:^{
            _launchImaViewO.alpha = 0.f;
            _launchImaViewT.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            [_launchImaViewO removeFromSuperview];
            [_launchImaViewT removeFromSuperview];
        }];
    } failure:nil];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    CGPoint location = [[[event allTouches] anyObject] locationInView:[self window]];
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    if (CGRectContainsPoint(statusBarFrame, location)) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TapStatusBar" object:nil];
    }
}


@end
