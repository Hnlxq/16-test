//
//  DailyThemesViewModel.h
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/23.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyThemesViewModel : NSObject


@property (strong,nonatomic) NSMutableArray *stories;
@property (strong,nonatomic) NSString *imageURLStr;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSArray *editors;

- (void)getDailyThemesDataWithThemeID:(NSNumber *)themeID;

@end
