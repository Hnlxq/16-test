//
//  ThemeItemModel.m
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/21.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import "ThemeItemModel.h"

@implementation ThemeItemModel

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"themeID"];
    }
}

@end
