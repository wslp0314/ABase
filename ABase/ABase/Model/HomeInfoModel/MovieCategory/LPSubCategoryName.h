//
//  LPCategoryName.h
//  ABASE!!!
//
//  Created by wslp0314 on 2017/4/19.
//  Copyright © 2017年 abase. All rights reserved.
//

#import "GCBaseModel.h"

@interface LPSubCategoryName : GCBaseModel
@property (strong, nonatomic) NSString *categoryName;
@property (strong, nonatomic) NSString *categoryId;

@end


@interface LPTotalCategoryName : GCBaseModel
@property (strong, nonatomic) NSArray <LPSubCategoryName *>*subCategoryList;
@property (strong, nonatomic) NSString *totalCategoryName;

@end

@interface LPCategoryNameList : GCBaseModel
@property (strong, nonatomic) NSArray <LPTotalCategoryName *>* categoryNameList;

+ (instancetype) categoryNameList;
- (void)categoryNameListToModel:(NSDictionary *)dic completion:(void (^)(LPCategoryNameList *categoryNameList, NSDictionary *dic, NSError *error))completion;

@end
