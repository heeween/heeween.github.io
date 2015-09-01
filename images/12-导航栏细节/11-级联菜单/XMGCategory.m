//
//  XMGCategory.m
//  10-级联菜单
//
//  Created by xiaomage on 15/7/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGCategory.h"

@implementation XMGCategory
+ (instancetype)categoryWithDict:(NSDictionary *)dict
{
    XMGCategory *c = [[self alloc] init];
    [c setValuesForKeysWithDictionary:dict];
    return c;
}
@end
