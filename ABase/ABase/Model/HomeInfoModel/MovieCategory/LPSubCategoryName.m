//
//  LPCategoryName.m
//  ABASE!!!
//
//  Created by wslp0314 on 2017/4/19.
//  Copyright © 2017年 abase. All rights reserved.
//

#import "LPSubCategoryName.h"

@implementation LPSubCategoryName
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"categoryName"        :     @"categoryName",
             @"categoryId"          :     @"categoryId"
             };
}

+ (NSArray *)createWithInfos:(NSArray *)infos {
    NSMutableArray *shareCarUserInfo = [NSMutableArray array];
    for(NSDictionary *info in infos) {
        [shareCarUserInfo addObject:[LPSubCategoryName createWithDictionary:info]];
    }
    return shareCarUserInfo;
}
@end

@implementation LPTotalCategoryName
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"subCategoryList"        :     @"subCategorys",
             @"totalCategoryName"      :     @"totalCategoryName"
             };
}

+ (NSArray *)createWithInfos:(NSArray *)infos {
    NSMutableArray *shareCarUserInfo = [NSMutableArray array];
    for(NSDictionary *info in infos) {
        [shareCarUserInfo addObject:[LPTotalCategoryName createWithDictionary:info]];
    }
    return shareCarUserInfo;
}

+ (NSValueTransformer *)subCategoryListJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *categoryNameList, BOOL *success, NSError *__autoreleasing *error) {
        return [LPSubCategoryName createWithInfos:categoryNameList];
    }];
}

@end


@implementation LPCategoryNameList
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"categoryNameList"    :     @"aBaseCategory",
             };
}

+ (NSValueTransformer *)categoryNameListJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *categoryNameList, BOOL *success, NSError *__autoreleasing *error) {
        return [LPTotalCategoryName createWithInfos:categoryNameList];
    }];
}

//解析JpushInfo 返回的数据(字典转模型)
+ (instancetype) categoryNameList {
    static LPCategoryNameList *categoryNameList = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        categoryNameList = [LPCategoryNameList new];
    });
    return categoryNameList;
}

- (void)categoryNameListToModel:(NSDictionary *)dic completion:(void (^)(LPCategoryNameList *categoryNameList, NSDictionary *dic, NSError *error))completion {
    NSError *error;
    if (!dic) {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"JpushInfo没有数据"};
        error = [NSError errorWithDomain:@"domain" code:-1 userInfo:userInfo];
    }
    [self fillWithDictionary:dic];
    
    completion(self,dic,error);
    NSLog(@"socket的返回数据:%@",dic);
}


@end



