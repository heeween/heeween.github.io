//
//  XMGCategory.h
//  10-级联菜单
//
//  Created by xiaomage on 15/7/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGCategory : NSObject
/** 子类别 */
@property (nonatomic, strong) NSArray *subcategories;
/** 姓名 */
@property (nonatomic, strong) NSString *name;
/** 图标 */
@property (nonatomic, strong) NSString *icon;
/** 高亮图标 */
@property (nonatomic, strong) NSString *highlighted_icon;

+ (instancetype)categoryWithDict:(NSDictionary *)dict;
@end
