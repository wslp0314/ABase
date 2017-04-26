//
//  LTBaseTableCellEntity.h
//  LTFramework
//
//  Created by zty on 5/6/16.
//  Copyright © 2016 Lngtop. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LTProtocol.h"

@interface LTBaseTableCellEntity : NSObject <LTBaseTableCellEntityDelegate>

@property (nonatomic) NSString *entityID;
@property (nonatomic) NSString *reuseCellID;
@property (nonatomic) Class<LTBaseTableCellLayout> cellClass;

@property (nonatomic) id        dataEntity;

@property (nonatomic) CGFloat   layoutHeight;

@property (nonatomic) NSInteger tag;

+ (instancetype)entityWithEntityID:(NSString *)entityID
                       cellReUseID:(NSString *)cellReUseID
                         cellClass:(Class<LTBaseTableCellLayout>)cellClass
                        dataEntity:(id)dataEntity
                precalculateHeight:(BOOL)precalculateHeight;

+ (NSMutableArray *)sectionListWithData:(id)data;

@end

