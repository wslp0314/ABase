//
//  UIView+EasyUseGeometry.h
//  LngtopFramework
//
//  Created by Martin Yin on 3/16/2015.
//  Copyright (c) 2015 Lngtop. All rights reserved.
//

#import <UIKit/UIKit.h>

BOOL TTIsKeyboardVisible();

@interface UIView (EasyUseGeometry)

- (CGFloat)left;
- (void)setLeft:(CGFloat)x;

- (CGFloat)top;
- (void)setTop:(CGFloat)y;

- (CGFloat)right;
- (void)setRight:(CGFloat)right;

- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;

- (CGFloat)centerX;
- (void)setCenterX:(CGFloat)centerX;

- (CGFloat)centerY;
- (void)setCenterY:(CGFloat)centerY;

- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

- (CGFloat)ttScreenX;
- (CGFloat)ttScreenY;
- (CGFloat)screenViewX;
- (CGFloat)screenViewY;
- (CGRect)screenFrame;

- (CGPoint)origin;
- (void)setOrigin:(CGPoint)origin;

- (CGSize)size;
- (void)setSize:(CGSize)size;

- (void)removeAllSubviews;

- (CGPoint)offsetFromView:(UIView*)otherView;

- (UIViewController*)viewController;
@end
