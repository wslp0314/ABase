//
//  movieSimpleInfo.m
//  ABASE!!!
//
//  Created by wslp0314 on 2017/4/19.
//  Copyright © 2017年 abase. All rights reserved.
//

#import "LPMovieSimpleInfo.h"
@implementation LPActorInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"actorAllMovieUrl"         :     @"actorAllMovieUrl",
             @"actorName"                :     @"actorName"
             };
}

+ (NSArray *)createWithInfos:(NSArray *)infos {
    NSMutableArray *movieSimpleInfo = [NSMutableArray array];
    if ([infos isKindOfClass:([NSString class])]) {
        
    } else {
        for(NSDictionary *info in infos) {
            [movieSimpleInfo addObject:[LPActorInfo createWithDictionary:info]];
        }
    }
    
    return movieSimpleInfo;
}
@end

@implementation LPGenreInfo
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"genre"         :     @"genre",
             @"genreUrl"      :     @"genreUrl"
             };
}

+ (NSArray *)createWithInfos:(NSArray *)infos {
    NSMutableArray *movieSimpleInfo = [NSMutableArray array];
    if ([infos isKindOfClass:([NSString class])]) {
        
    } else {
        for(NSDictionary *info in infos) {
            [movieSimpleInfo addObject:[LPGenreInfo createWithDictionary:info]];
        }
    }
    
    return movieSimpleInfo;
}

@end

@implementation LPMovieSimpleInfo
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"genreList"      :     @"genres",
             @"actorList"      :     @"actors",
             @"designation"    :     @"designation",
             @"seedState"      :     @"seedState",
             @"subtitles"      :     @"subtitles",
             @"iconUrl"        :     @"iconUrl",
             @"movieName"      :     @"movieName",
             @"releaseTime"    :     @"releaseTime",
             };
}

+ (NSValueTransformer *)genreListJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *genreList, BOOL *success, NSError *__autoreleasing *error) {
        return [LPGenreInfo createWithInfos:genreList];
    }];
}

+ (NSValueTransformer *)actorListJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *actorList, BOOL *success, NSError *__autoreleasing *error) {
        return [LPActorInfo createWithInfos:actorList];
    }];
}

+ (NSArray *)createWithInfos:(NSArray *)infos {
    NSMutableArray *movieSimpleInfo = [NSMutableArray array];
    for(NSDictionary *info in infos) {
        [movieSimpleInfo addObject:[LPMovieSimpleInfo createWithDictionary:info]];
    }
    return movieSimpleInfo;
}
@end

@implementation LPPageInfo
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"nextPageUrl"      :     @"nextPageUrl",
             @"movieInfoList"    :     @"movieInfoArray"
             };
}

+ (NSValueTransformer *)movieInfoListJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *movieInfoList, BOOL *success, NSError *__autoreleasing *error) {
        return [LPMovieSimpleInfo createWithInfos:movieInfoList];
    }];
}

//解析JpushInfo 返回的数据(字典转模型)
+ (instancetype) pageInfo {
    static LPPageInfo *pageInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pageInfo = [LPPageInfo new];
    });
    return pageInfo;
}

- (void)pageInfoToModel:(NSDictionary *)dic completion:(void (^)(LPPageInfo *pageInfo, NSDictionary *dic, NSError *error))completion {
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

