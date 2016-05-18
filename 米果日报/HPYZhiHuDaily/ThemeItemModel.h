//
//  ThemeItemModel.h
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/21.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeItemModel : NSObject

@property(copy,nonatomic) NSString *name;
@property(copy,nonatomic) NSNumber *themeID;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
