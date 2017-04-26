//
//  UIView+GCExtension.h
//  GasChat
//
//  Created by Martin Yin on 3/25/2016.
//  Copyright © 2016 Lngtop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LayerAccessExtension)

@property (assign, nonatomic) CGFloat cornerRadius;
@property (strong, nonatomic) UIColor *borderColor;
@property (assign, nonatomic) CGFloat borderWidth;

- (void)removeSubLayer:(NSString *)layerName;

@end

typedef NS_ENUM(NSInteger, UIViewBorderDirection) {
    UIViewBorderDirectionTop    = 1,
    UIViewBorderDirectionBottom = 2,
    UIViewBorderDirectionLeft   = 4,
    UIViewBorderDirectionRight  = 8,
};

@interface UIView (BorderExt)

- (void)addTopBorder:(UIColor *)color width:(CGFloat)width inset:(CGFloat)inset;
- (void)addBottomBorder:(UIColor *)color width:(CGFloat)width inset:(CGFloat)inset;
- (void)addLeftBorder:(UIColor *)color width:(CGFloat)width inset:(CGFloat)inset;
- (void)addRightBorder:(UIColor *)color width:(CGFloat)width inset:(CGFloat)inset;

- (void)addBorder:(UIViewBorderDirection)direction color:(UIColor *)color width:(CGFloat)width inset:(CGFloat)inset;
- (void)addBorder:(UIViewBorderDirection)direction;

- (void)removeBorderWithName:(NSString *)name;

- (void)removeTopBorder;
- (void)removeBottomBorder;
- (void)removeLeftBorder;
- (void)removeRightBorder;

- (void)removeBorder:(UIViewBorderDirection)direction;

- (void)addRoundBorderEffect;
- (void)addRoundBorderEffect:(BOOL)roundCorner border:(BOOL)border opacity:(float)opacity shadow:(BOOL)shadow;
- (void)addRoundBorderEffect:(BOOL)roundCorner cornerRadius:(CGFloat)cornerRadius border:(BOOL)border borderWidth:(CGFloat)borderWidth opacity:(float)opacity shadow:(BOOL)shadow;

- (void)addShadowEffect;

@end
