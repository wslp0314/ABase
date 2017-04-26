//
//  LTBaseTableCell.h
//  LTFramework
//
//  Created by zty on 4/5/16.
//  Copyright © 2016 Lngtop. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LTProtocol.h"

@interface LTBaseTableCell : UITableViewCell <LTBaseTableCellLayout>

@property (weak, nonatomic) id<LTBaseTableCellDelegate> delegate;

+ (NSString *)reuseCellID;

- (void)configureWithEntity:(id<LTBaseTableCellEntityDelegate>)entity;

@end
