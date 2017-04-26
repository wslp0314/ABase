//
//  LTBaseTableCellEntity.m
//  LTFramework
//
//  Created by zty on 5/6/16.
//  Copyright © 2016 Lngtop. All rights reserved.
//

#import "LTBaseTableCellEntity.h"

@implementation LTBaseTableCellEntity

+ (instancetype)entityWithEntityID:(NSString *)entityID
                       cellReUseID:(NSString *)cellReUseID
                         cellClass:(Class<LTBaseTableCellLayout>)cellClass
                        dataEntity:(id)dataEntity
                precalculateHeight:(BOOL)precalculateHeight {

    LTBaseTableCellEntity *entity = [self new];

    [entity setEntityID:entityID];
    [entity setReuseCellID:cellReUseID];
    [entity setDataEntity:dataEntity];

    [entity setCellClass:cellClass];

    if (precalculateHeight) {
        [entity setLayoutHeight:[cellClass layoutHeightWithEntity:dataEntity]];
    }

    return entity;
}

+ (NSMutableArray *)sectionListWithData:(id)data {

    return nil;
}

- (CGFloat)layoutHeight {
    if (_layoutHeight > 0) {

        return _layoutHeight;
    }

    _layoutHeight = [[self cellClass] layoutHeightWithEntity:[self dataEntity]];

    return _layoutHeight;
}

@end
