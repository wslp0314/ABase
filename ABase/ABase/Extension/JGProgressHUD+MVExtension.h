//
//  JGProgressHUD+MVExtension.h
//  GasChat
//
//  Created by Martin Yin on 12/14/2015.
//  Copyright © 2015 Lngtop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGProgressHUD.h"

@interface JGProgressHUD (MVExtension)

@property (nonatomic, strong) JGProgressHUD *hud;



+ (instancetype)createHud;

- (void)setDefaultShadow;

- (void)addGlowAnimation:(UIColor *)color;
- (void)removeGlowAnimation;

- (void)addRedGlowAnimation;
- (void)addGreenGlowAnimation;

- (void)dismissAfterDelay:(NSTimeInterval)delay action:(void (^)())action;
- (void)dismissAfterDelay:(NSTimeInterval)delay animated:(BOOL)animated action:(void (^)())action;

- (void) showHudWith:(NSString *)text;
- (void) hideHud;

@end
