//
//  LMLayout.h
//  LMLayout
//
//  Created by lemon on 2017/12/7.
//  Copyright © 2017年 Lemon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LMLayout;

typedef NS_ENUM(NSUInteger,PropertyType) {
    PropertyTypeTop = 1,
    PropertyTypeLeft ,
    PropertyTypeBottom ,
    PropertyTypeRight ,
    PropertyTypeWidth ,
    PropertyTypeHeight,
    PropertyTypeCenterX,
    PropertyTypeCenterY
};



typedef LMLayout*(^LayoutPropertyBlock)(NSObject *object);
typedef void(^LayoutOffsetBlock)(CGFloat offset);

@interface LMLayout : NSObject
+ (NSLayoutAttribute)attributeWithProperty:(PropertyType)type;
- (instancetype)initWithView:(UIView*)view;
- (void)clearAllLayout;
//需要设置约束的属性
-(LMLayout*)left;
-(LMLayout*)right;
-(LMLayout*)top;
-(LMLayout*)bottom;
-(LMLayout*)width;
-(LMLayout*)height;
-(LayoutPropertyBlock)equalTo;
-(LayoutOffsetBlock)offSet;
@end


