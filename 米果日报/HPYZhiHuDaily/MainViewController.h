//
//  MainViewController.h
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/11.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "LeftMenuViewController.h"

@interface MainViewController : UIViewController

- (instancetype)initWithLeftMenuViewController:(LeftMenuViewController *) menuVC andHomeViewController:(HomeViewController *) homeVC;

- (void)showMainView;
- (void)showLeftMenuView;

@end
