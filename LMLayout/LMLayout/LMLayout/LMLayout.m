//
//  LMLayout.m
//  LMLayout
//
//  Created by lemon on 2017/12/7.
//  Copyright © 2017年 Lemon. All rights reserved.
//

#import "LMLayout.h"

@interface LMLayout()
@property (nonatomic, weak) UIView *view;
@property (nonatomic, assign) PropertyType property;
@property (nonatomic, weak) UIView *conferenceView;
@property (nonatomic, assign) NSLayoutAttribute conferProperty;
@property (nonatomic, strong) NSLayoutConstraint *currentConstraint;
@end

@implementation LMLayout

- (instancetype)initWithView:(UIView *)view{
    NSAssert([view superview]!=nil, @"未能找到view的superView");
    if (self = [super init]) {
        _view = view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

#pragma mark - 保存要设置约束的属性
-(LMLayout*)left{
    _property = PropertyTypeLeft;
    return self;
}
-(LMLayout*)right{
    _property = PropertyTypeRight;
    return self;
}
-(LMLayout*)top{
    _property = PropertyTypeTop;
    return self;
}
-(LMLayout*)bottom{
    _property = PropertyTypeBottom;
    return self;
}

-(LMLayout*)width{
    _property = PropertyTypeWidth;
    return self;
}
-(LMLayout*)height{
    _property = PropertyTypeHeight;
    return self;
}


#pragma mark - 添加约束方法
-(LayoutPropertyBlock)equalTo{
    __weak typeof(self)weakSelf = self;
    return ^(NSObject *object){
        //判断外部调用equalTo()这个block的时候会传什么值
        //如果是直接设置属性的值
        if ([object isKindOfClass:[NSNumber class]]) {
            CGFloat floatValue = [(NSNumber*)object floatValue];
            NSLayoutAttribute attribute = NSLayoutAttributeHeight;
            switch (weakSelf.property) {
                case PropertyTypeWidth:
                    attribute = NSLayoutAttributeWidth;
                    break;
                case PropertyTypeHeight:
                    attribute = NSLayoutAttributeHeight;
                    break;
                default:
                    attribute = NSLayoutAttributeNotAnAttribute;
                    break;
            }
            NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:weakSelf.view attribute:attribute relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:floatValue];
            //检测之前是否已经设置了旧的同一属性的约束，如果是就删除，添加新的约束
            [weakSelf checkIfExistOldLayoutWithNewLayout:constraint];
            [weakSelf.view addConstraint:constraint];
        }
        //如果是设置一个参照view
        else if([object isKindOfClass:[NSDictionary class]]){
            NSDictionary *dict = (NSDictionary*)object;
            UIView *view = (UIView *)dict[@"view"];
            weakSelf.conferenceView = view;
            weakSelf.conferProperty = [dict[@"property"] floatValue];
            NSLayoutAttribute attribute = [LMLayout attributeWithProperty:weakSelf.property];
            NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:weakSelf.view attribute:attribute relatedBy:NSLayoutRelationEqual toItem:weakSelf.conferenceView attribute:weakSelf.conferProperty multiplier:1 constant:0];
            //检测之前是否已经设置了旧的同一属性的约束，如果是就删除，添加新的约束
            [weakSelf checkIfExistOldLayoutWithNewLayout:constraint];
            weakSelf.currentConstraint = constraint;
            [weakSelf.view.superview addConstraint:constraint];

        }
        return self;
    };
}
-(LayoutOffsetBlock)offSet{
    __weak typeof(self)weakSelf = self;
    return ^(CGFloat margin){
        NSLayoutAttribute attribute = [LMLayout attributeWithProperty:weakSelf.property];
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:weakSelf.view attribute:attribute relatedBy:NSLayoutRelationEqual toItem:weakSelf.conferenceView attribute:weakSelf.conferProperty multiplier:1 constant:margin];
        if (weakSelf.currentConstraint.firstItem == constraint.firstItem && weakSelf.currentConstraint.firstAttribute == constraint.firstAttribute && weakSelf.currentConstraint.secondItem == constraint.secondItem && weakSelf.currentConstraint.secondAttribute == constraint.secondAttribute) {
            weakSelf.currentConstraint.constant = margin;
            //[weakSelf.view.superview removeConstraint:weakSelf.currentConstraint];
           // [weakSelf.view.superview addConstraint:constraint];
        }
    };
}

#pragma mark - 清除所有的约束
- (void)clearAllLayout{
    NSArray *constraints = [self.view constraints];
    for (NSLayoutConstraint *constraint in constraints) {
        [self.view removeConstraint:constraint];
    }
    NSArray *superViewConstraints = [self.view.superview constraints];
    for (NSLayoutConstraint *constraint in superViewConstraints) {
        if (constraint.firstItem == self.view) {
            [self.view.superview removeConstraint:constraint];
        }
    }
}

- (void)checkIfExistOldLayoutWithNewLayout:(NSLayoutConstraint*)newConstraint{
    NSArray *constraints = [self.view constraints];
    for (NSLayoutConstraint *constraint in constraints) {
        if (constraint.firstItem == newConstraint.firstItem && constraint.firstAttribute == newConstraint.firstAttribute) {
            [self.view removeConstraint:constraint];
        }
    }
    NSArray *superViewConstraints = [self.view.superview constraints];
    for (NSLayoutConstraint *constraint in superViewConstraints) {
        if (constraint.firstItem == newConstraint.firstItem && constraint.firstAttribute == newConstraint.firstAttribute) {
            [self.view removeConstraint:constraint];
        }
    }

}

#pragma mark - 根据枚举拿到属性值
+ (NSLayoutAttribute)attributeWithProperty:(PropertyType)type{
    switch (type) {
        case PropertyTypeTop:
            return NSLayoutAttributeTop;
        case PropertyTypeBottom:
            return NSLayoutAttributeBottom;
        case PropertyTypeLeft:
            return NSLayoutAttributeLeft;
        case  PropertyTypeRight:
            return NSLayoutAttributeRight;
        case  PropertyTypeHeight:
            return NSLayoutAttributeHeight;
        case PropertyTypeWidth:
            return NSLayoutAttributeWidth;
        case PropertyTypeCenterX:
            return NSLayoutAttributeCenterX;
        case  PropertyTypeCenterY:
            return NSLayoutAttributeCenterY;
        default:
            return NSLayoutAttributeNotAnAttribute;
            break;
    }
}


@end
