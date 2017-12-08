//
//  UIView+layout.m
//  LMLayout
//
//  Created by lemon on 2017/12/8.
//  Copyright © 2017年 Lemon. All rights reserved.
//

#import "UIView+layout.h"

@implementation UIView (layout)
- (void)makeLayout:(void(^)(LMLayout *layout))layoutBlock{
    LMLayout *layout = [[LMLayout alloc]initWithView:self];
    layoutBlock(layout);
}

- (void)updateLayout:(void(^)(LMLayout *layout))layoutBlock{
    LMLayout *layout = [[LMLayout alloc]initWithView:self];
    layoutBlock(layout);
}

- (void)remakeLayout:(void(^)(LMLayout *layout))layoutBlock{
    LMLayout *layout = [[LMLayout alloc]initWithView:self];
    [layout clearAllLayout];
    layoutBlock(layout);
}



-(NSDictionary<UIView *,NSNumber *>*)lm_left{
    return [self dictWithProperty:PropertyTypeLeft];
}
-(NSDictionary<UIView *,NSNumber *>*)lm_right{
    return [self dictWithProperty:PropertyTypeRight];
}
-(NSDictionary<UIView *,NSNumber *>*)lm_top{
    return [self dictWithProperty:PropertyTypeTop];
}
-(NSDictionary<UIView *,NSNumber *>*)lm_bottom{
    return [self dictWithProperty:PropertyTypeBottom];
}
-(NSDictionary<UIView *,NSNumber *>*)lm_width{
    return [self dictWithProperty:PropertyTypeWidth];
}
-(NSDictionary<UIView *,NSNumber *>*)lm_height{
    return [self dictWithProperty:PropertyTypeHeight];
}

-(NSDictionary<UIView *,NSNumber *>*)lm_centerX{
    return [self dictWithProperty:PropertyTypeCenterX];
}
-(NSDictionary<UIView *,NSNumber *>*)lm_centerY{
    return [self dictWithProperty:PropertyTypeCenterY];
}

- (NSDictionary<UIView *,NSNumber *>*)dictWithProperty:(PropertyType)type{
    NSDictionary *dict = @{@"view":self,@"property":@([LMLayout attributeWithProperty:type])};
    return dict;
}



@end
