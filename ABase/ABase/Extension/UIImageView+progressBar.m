//
//  UIImageView+progressBar.m
//  GET FUTA!!!
//
//  Created by wslp0314 on 16/6/3.
//  Copyright © 2016年 wslp0314. All rights reserved.
//

#import "UIImageView+progressBar.h"

@implementation UIImageView (progressBar)

- (void) addProgressBar {
    UIImageView *imageViewTop = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    imageViewTop.backgroundColor = [UIColor greenColor];
    UIImageView *imageViewRight = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 1, 1, 1, self.frame.size.height - 1)];
    imageViewRight.backgroundColor = [UIColor greenColor];
    UIImageView *imageViewBottom = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.width, 1, self.frame.size.height - 1)];
    imageViewBottom.backgroundColor = [UIColor greenColor];
    UIImageView *imageViewLeft = [[UIImageView alloc]initWithFrame:CGRectMake(0, 1, 1, self.frame.size.height - 1)];
    imageViewLeft.backgroundColor = [UIColor greenColor];
    [self addSubview:imageViewTop];
    [self addSubview:imageViewRight];
    [self addSubview:imageViewBottom];
    [self addSubview:imageViewLeft];
}
@end
