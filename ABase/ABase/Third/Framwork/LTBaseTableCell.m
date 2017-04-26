//
//  LTBaseTableCell.m
//  LTFramework
//
//  Created by zty on 4/5/16.
//  Copyright © 2016 Lngtop. All rights reserved.
//

#import "LTBaseTableCell.h"

@implementation LTBaseTableCell

+ (CGFloat)layoutHeightWithEntity:(id)entity {

    return 44;
}

+ (NSString *)reuseCellID {

    return NSStringFromClass([self class]);
}

- (void)configureWithEntity:(id<LTBaseTableCellEntityDelegate>)entity {
    
}

@end
