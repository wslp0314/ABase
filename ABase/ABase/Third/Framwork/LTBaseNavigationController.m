//
//  LTBaseNavigationController.m
//  LTFramework
//
//  Created by zty on 4/9/16.
//  Copyright © 2016 Lngtop. All rights reserved.
//

#import "LTBaseNavigationController.h"

@implementation LTBaseNavigationController

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return [[self topViewController] preferredStatusBarStyle];
}

@end
