//
//  UIView+GCExtension.m
//  GasChat
//
//  Created by Martin Yin on 3/25/2016.
//  Copyright © 2016 Lngtop. All rights reserved.
//

#import "UIView+GCExtension.h"
#import "MVTheme.h"
#import "MVThemeManager.h"
#import "NSArray+GCExtension.h"

@implementation UIView (LayerAccessExtension)

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = [borderColor CGColor];
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (void)removeSubLayer:(NSString *)layerName {
    if(self.layer.sublayers.count > 0) {
        NSMutableArray *needRemoveLayers = [NSMutableArray arrayWithArray:[self.layer.sublayers filterObjectsUsingBlock:^BOOL(CALayer *layer, NSUInteger idx) {
            return [layer.name isEqualToString:layerName];
        }]];

        while(needRemoveLayers.count > 0) {
            [needRemoveLayers.lastObject removeFromSuperlayer];
            [needRemoveLayers removeLastObject];
        }
    }
}

@end

@implementation UIView (BorderExt)

- (void)addTopBorder:(UIColor *)color width:(CGFloat)width inset:(CGFloat)inset {
    [self addBorder:UIViewBorderDirectionTop color:color width:width inset:inset];
}

- (void)addBottomBorder:(UIColor *)color width:(CGFloat)width inset:(CGFloat)inset {
    [self addBorder:UIViewBorderDirectionBottom color:color width:width inset:inset];
}

- (void)addLeftBorder:(UIColor *)color width:(CGFloat)width inset:(CGFloat)inset {
    [self addBorder:UIViewBorderDirectionLeft color:color width:width inset:inset];
}

- (void)addRightBorder:(UIColor *)color width:(CGFloat)width inset:(CGFloat)inset {
    [self addBorder:UIViewBorderDirectionRight color:color width:width inset:inset];
}

- (void)addSingleBorder:(NSString *)name color:(UIColor *)color frame:(CGRect)frame {
    [self removeBorderWithName:name];
    
    CALayer *border = [[CALayer alloc] init];
    border.name = name;
    border.backgroundColor = color.CGColor;
    
    border.frame = frame;
    
    [self.layer addSublayer:border];
}

- (void)addBorder:(UIViewBorderDirection)direction color:(UIColor *)color width:(CGFloat)width inset:(CGFloat)inset {
    if((direction & UIViewBorderDirectionTop) == UIViewBorderDirectionTop) {
        [self addSingleBorder:@"UIViewBorderTop" color:color frame:CGRectMake(inset, 0, self.frame.size.width-inset-inset, width)];
    }

    if((direction & UIViewBorderDirectionBottom) == UIViewBorderDirectionBottom) {
        [self addSingleBorder:@"UIViewBorderBottom" color:color frame:CGRectMake(inset, self.frame.size.height - width, self.frame.size.width-inset-inset, width)];
    }

    if((direction & UIViewBorderDirectionLeft) == UIViewBorderDirectionLeft) {
        [self addSingleBorder:@"UIViewBorderLeft" color:color frame:CGRectMake(0, inset, width, self.frame.size.height-inset-inset)];
    }

    if((direction & UIViewBorderDirectionRight) == UIViewBorderDirectionRight) {
        [self addSingleBorder:@"UIViewBorderRight" color:color frame:CGRectMake(self.frame.size.width - width, inset, width, self.frame.size.height-inset-inset)];
    }
}

- (void)addBorder:(UIViewBorderDirection)direction {
    [self addBorder:direction color:[MVThemeManager colorWithName:@"CommonSeparatorColor"] width:1 inset:0];
}

- (void)removeBorderWithName:(NSString *)name {
    [self removeSubLayer:name];
}

- (void)removeTopBorder {
    [self removeBorder:UIViewBorderDirectionTop];
}

- (void)removeBottomBorder {
    [self removeBorder:UIViewBorderDirectionBottom];
}

- (void)removeLeftBorder {
    [self removeBorder:UIViewBorderDirectionLeft];
}

- (void)removeRightBorder {
    [self removeBorder:UIViewBorderDirectionRight];
}

- (void)removeBorder:(UIViewBorderDirection)direction {
    if((direction & UIViewBorderDirectionTop) == UIViewBorderDirectionTop) {
        [self removeSubLayer:@"UIViewBorderTop"];
    }
    
    if((direction & UIViewBorderDirectionBottom) == UIViewBorderDirectionBottom) {
        [self removeSubLayer:@"UIViewBorderBottom"];
    }
    
    if((direction & UIViewBorderDirectionLeft) == UIViewBorderDirectionLeft) {
        [self removeSubLayer:@"UIViewBorderLeft"];
    }
    
    if((direction & UIViewBorderDirectionRight) == UIViewBorderDirectionRight) {
        [self removeSubLayer:@"UIViewBorderRight"];
    }
}

- (void)addRoundBorderEffect {
    [self addRoundBorderEffect:TRUE border:TRUE opacity:1 shadow:TRUE];
}

- (void)addRoundBorderEffect:(BOOL)roundCorner border:(BOOL)border opacity:(float)opacity shadow:(BOOL)shadow {
    [self addRoundBorderEffect:roundCorner cornerRadius:3 border:border borderWidth:1 opacity:opacity shadow:shadow];
}

- (void)addRoundBorderEffect:(BOOL)roundCorner cornerRadius:(CGFloat)cornerRadius border:(BOOL)border borderWidth:(CGFloat)borderWidth opacity:(float)opacity shadow:(BOOL)shadow {
    if(roundCorner) {
        self.cornerRadius = cornerRadius;
    }
    
    if(border) {
        self.borderWidth = borderWidth;
        self.borderColor = [MVThemeManager colorWithName:@"MapButtonBorderColor"];
    }
    
    self.layer.opacity = opacity;
    
    if(shadow) {
        self.clipsToBounds = FALSE;
        self.layer.shadowColor = UIColor.blackColor.CGColor;
        self.layer.shadowOffset = CGSizeZero;
        self.layer.shadowRadius = 1;
        self.layer.shadowOpacity = 0.1;
    }
}

- (void)addShadowEffect {
    [[self layer] setMasksToBounds:NO];
    [[self layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self layer] setShadowOffset:CGSizeMake(0.0f, 1.0f)];
    [[self layer] setShadowOpacity:0.5f];
    [[self layer] setShadowRadius:1.5];
    [[self layer] setShadowPath:[[UIBezierPath bezierPathWithRect:[self bounds]] CGPath]];
}

@end
