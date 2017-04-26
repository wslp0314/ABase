//
//  JGProgressHUD+MVExtension.m
//  GasChat
//
//  Created by Martin Yin on 12/14/2015.
//  Copyright © 2015 Lngtop. All rights reserved.
//

#import "JGProgressHUD.h"
//#import "GCCommons.h"

@implementation JGProgressHUD (MVExtension)

+ (instancetype)createHud {
    JGProgressHUD *hud = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleExtraLight];
    
    hud.interactionType = JGProgressHUDInteractionTypeBlockAllTouches;
    hud.animation = [[JGProgressHUDFadeZoomAnimation alloc] init];
    hud.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    
    [hud setDefaultShadow];
    
    return hud;
}

- (void)setDefaultShadow {
    self.HUDView.layer.shadowColor   = [[UIColor blackColor] CGColor];
    self.HUDView.layer.shadowOffset  = CGSizeZero;
    self.HUDView.layer.shadowOpacity = 0.4;
    self.HUDView.layer.shadowRadius  = 8.0;
}

- (void)addGlowAnimation:(UIColor *)color {
    [self removeGlowAnimation];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    animation.fromValue = @0.0;
    animation.toValue   = @0.5;
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = TRUE;
    animation.duration = 0.75;
    
    self.HUDView.layer.shadowColor = [color CGColor];
    self.HUDView.layer.shadowOffset  = CGSizeZero;
    self.HUDView.layer.shadowOpacity = 0.0;
    self.HUDView.layer.shadowRadius  = 8.0;
    
    [self.HUDView.layer addAnimation:animation forKey:@"glow"];
}

- (void)removeGlowAnimation {
    [self.HUDView.layer removeAnimationForKey:@"glow"];
    
    [self setDefaultShadow];
}

- (void)addRedGlowAnimation {
    [self addGlowAnimation:[UIColor redColor]];
}

- (void)addGreenGlowAnimation {
    [self addGlowAnimation:[UIColor greenColor]];
}

- (void)dismissAfterDelay:(NSTimeInterval)delay action:(void (^)())action {
    [self dismissAfterDelay:delay animated:TRUE action:action];
}

- (void)dismissAfterDelay:(NSTimeInterval)delay animated:(BOOL)animated action:(void (^)())action {
    __weak __typeof(self)wself = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong __typeof(wself) sself = wself;
        
        [sself dismissAnimated:animated];
        action();
    });
}

@end
