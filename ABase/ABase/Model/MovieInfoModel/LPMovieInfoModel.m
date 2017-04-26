//
//  LPMovieInfoModel.m
//  ABASE!!!
//
//  Created by wslp0314 on 2017/4/22.
//  Copyright © 2017年 abase. All rights reserved.
//

#import "LPMovieInfoModel.h"

@implementation LPMovieActor
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"actUrl"          :       @"actUrl",
             @"actIconUrl"      :       @"actIconUrl",
             @"actInfoStr"      :       @"actInfoStr",
             @"actName"         :       @"actName"
             };
}

+ (NSArray *)createWithInfos:(NSArray *)infos {
    NSMutableArray *movieActor = [NSMutableArray array];
    if ([infos isKindOfClass:([NSString class])]) {
        
    } else {
        for(NSDictionary *info in infos) {
            [movieActor addObject:[LPMovieActor createWithDictionary:info]];
        }
    }
    
    return movieActor;
}
@end

@implementation LPMovieSnapshotUrl
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"thumbSnapshotUrl"      :   @"thumbSnapshotUrl",
             @"detailSnapshotUrl"     :   @"detailSnapshotUrl"
             };
}

+ (NSArray *)createWithInfos:(NSArray *)infos {
    NSMutableArray *movieSnapshotUrl = [NSMutableArray array];
    if ([infos isKindOfClass:([NSString class])]) {
        
    } else {
        for(NSDictionary *info in infos) {
            [movieSnapshotUrl addObject:[LPMovieSnapshotUrl createWithDictionary:info]];
        }
    }
    
    return movieSnapshotUrl;
}
@end

@implementation LPMovieSourceInfo
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"sourceTime"         :     @"sourceTime",
             @"sourceName"         :     @"sourceName",
             @"sourceUrl"          :     @"sourceUrl"
             };
}

+ (NSArray *)createWithInfos:(NSArray *)infos {
    NSMutableArray *movieSimpleInfo = [NSMutableArray array];
    for(NSDictionary *info in infos) {
        [movieSimpleInfo addObject:[LPMovieSourceInfo createWithDictionary:info]];
    }
    return movieSimpleInfo;
}
@end

@implementation LPMovieStyleInfo
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"movieStyleStr"      :     @"movieStyle",
             @"movieStyleUrl"      :     @"movieStyleUrl"
             };
}

+ (NSArray *)createWithInfos:(NSArray *)infos {
    NSMutableArray *movieStyleInfo = [NSMutableArray array];
    if ([infos isKindOfClass:([NSString class])]) {
        
    } else {
        for(NSDictionary *info in infos) {
            [movieStyleInfo addObject:[LPMovieStyleInfo createWithDictionary:info]];
        }
    }
    
    return movieStyleInfo;
}
@end

@implementation LPMovieName
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"movieName"         :     @"movieName",
             @"movieImage"        :     @"movieImage"
             };
}

@end

@implementation LPMovieSnapshots
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"movieSnapshotName"   :  @"movieSnapshotName",
             @"snapshotUrlList"     :  @"snapshotUrlArray"
             };
}

+ (NSValueTransformer *)sourceListJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *movieSnapshotUrl, BOOL *success, NSError *__autoreleasing *error) {
        return [LPMovieSnapshotUrl createWithInfos:movieSnapshotUrl];
    }];
}
@end

@implementation LPMovieSources
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"sourceName"        :     @"sourceName",
             @"sourceList"        :     @"sourceArray"
             };
}

+ (NSValueTransformer *)sourceListJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *movieSourceInfo, BOOL *success, NSError *__autoreleasing *error) {
        return [LPMovieSourceInfo createWithInfos:movieSourceInfo];
    }];
}
@end

@implementation LPMovieActorList
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"movieActorList"        :     @"movieActorArray"
             };
}

+ (NSValueTransformer *)sourceListJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *movieSourceInfo, BOOL *success, NSError *__autoreleasing *error) {
        return [LPMovieSourceInfo createWithInfos:movieSourceInfo];
    }];
}

@end

@implementation LPMovieDetail
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"movieIntroduce"        :     @"movieIntroduce",
             @"movieInfoStr"          :     @"movieInfoStr",
             @"movieStyleList"        :     @"movieStyleArray"
             };
}

+ (NSValueTransformer *)sourceListJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *movieStyleInfo, BOOL *success, NSError *__autoreleasing *error) {
        return [LPMovieStyleInfo createWithInfos:movieStyleInfo];
    }];
}

@end

@implementation LPMovieInfoModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"movieName"         :     @"movieName",
             @"movieSnapshots"    :     @"movieSnapshots",
             @"movieSources"      :     @"movieSources",
             @"movieActorList"    :     @"movieActorArray",
             @"movieDetail"       :     @"movieDetail"
             };
}



+ (NSValueTransformer *)movieNameJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:LPMovieName.class];
}

+ (NSValueTransformer *)movieSnapshotsJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:LPMovieSnapshots.class];
}

+ (NSValueTransformer *)movieSourcesJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:LPMovieSources.class];
}

+ (NSValueTransformer *)movieActorListJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:LPMovieActorList.class];
}

+ (NSValueTransformer *)movieDetailJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:LPMovieDetail.class];
}

//解析JpushInfo 返回的数据(字典转模型)
+ (instancetype) movieInfoModel {
    static LPMovieInfoModel *movieInfoModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        movieInfoModel = [LPMovieInfoModel new];
    });
    return movieInfoModel;
}

- (void)movieInfoToModel:(NSDictionary *)dic completion:(void (^)(LPMovieInfoModel *movieInfoModel, NSDictionary *dic, NSError *error))completion {
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

