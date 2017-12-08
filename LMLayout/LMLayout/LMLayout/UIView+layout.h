//
//  UIView+layout.h
//  LMLayout
//
//  Created by lemon on 2017/12/8.
//  Copyright © 2017年 Lemon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMLayout.h"


typedef NSDictionary*(^LayoutBlock)();


@interface UIView (layout)
//外部调用该方法去给设置view的约束
//第一次设置约束
- (void)makeLayout:(void(^)(LMLayout *layout))layoutBlock;
//更新某个约束
- (void)updateLayout:(void(^)(LMLayout *layout))layoutBlock;
//重新设置新的约束
- (void)remakeLayout:(void(^)(LMLayout *layout))layoutBlock;


//调用以下方法时，会返回一个字典，该字典会返回设置约束的参照view和参照属性
-(NSDictionary<UIView *,NSNumber *>*)lm_left;
-(NSDictionary<UIView *,NSNumber *>*)lm_right;
-(NSDictionary<UIView *,NSNumber *>*)lm_top;
-(NSDictionary<UIView *,NSNumber *>*)lm_bottom;
-(NSDictionary<UIView *,NSNumber *>*)lm_width;
-(NSDictionary<UIView *,NSNumber *>*)lm_height;
-(NSDictionary<UIView *,NSNumber *>*)lm_centerX;
-(NSDictionary<UIView *,NSNumber *>*)lm_centerY;
@end
