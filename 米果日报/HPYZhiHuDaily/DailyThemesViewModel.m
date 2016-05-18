//
//  DailyThemesViewModel.m
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/23.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import "DailyThemesViewModel.h"
#import "StoryModel.h"

@implementation DailyThemesViewModel

- (void)getDailyThemesDataWithThemeID:(NSNumber *)themeID {
    
    [HttpOperation getRequestWithURL:[NSString stringWithFormat:@"theme/%@",themeID] parameters:nil success:^(id responseObject) {
        NSDictionary *jsonDic = (NSDictionary *)responseObject;
        NSArray *storiesArr = jsonDic[@"stories"];
        NSMutableArray* tempArr = [NSMutableArray array];
        for (NSDictionary *dic in storiesArr) {
            StoryModel *model = [[StoryModel alloc] initWithDictionary:dic];
            [tempArr addObject:model];
        }
        [self setValue:tempArr forKey:@"stories"];
        [self setValue:jsonDic[@"background"] forKey:@"imageURLStr"];
        [self setValue:jsonDic[@"name"] forKey:@"name"];
        [self setValue:jsonDic[@"editors"] forKey:@"editors"];
    } failure:nil];
}

@end
