//
//  movieSimpleInfo.h
//  ABASE!!!
//
//  Created by wslp0314 on 2017/4/19.
//  Copyright © 2017年 abase. All rights reserved.
//

#import "GCBaseModel.h"
@interface LPActorInfo :GCBaseModel
@property (strong, nonatomic) NSString *actorAllMovieUrl;
@property (strong, nonatomic) NSString *actorName;
@end

@interface LPGenreInfo :GCBaseModel
@property (strong, nonatomic) NSString *genre;
@property (strong, nonatomic) NSString *genreUrl;
@end

@interface LPMovieSimpleInfo : GCBaseModel
//分类列表
@property (strong, nonatomic) NSArray <LPGenreInfo *>* genreList;
//演员列表
@property (strong, nonatomic) NSArray <LPActorInfo *>* actorList;
//番号
@property (strong, nonatomic) NSString *designation;
//资源状况(有种,无种)
@property (strong, nonatomic) NSString *seedState;
//中文字幕
@property (strong, nonatomic) NSString *subtitles;
//图片链接
@property (strong, nonatomic) NSString *iconUrl;
//电影名字
@property (strong, nonatomic) NSString *movieName;
//发布时间
@property (strong, nonatomic) NSString *releaseTime;
@end

@interface LPPageInfo :GCBaseModel
@property (strong, nonatomic) NSArray <LPMovieSimpleInfo *>*movieInfoList;
@property (strong, nonatomic) NSString *nextPageUrl;

+ (instancetype) pageInfo;
- (void)pageInfoToModel:(NSDictionary *)dic completion:(void (^)(LPPageInfo *pageInfo, NSDictionary *dic, NSError *error))completion;
@end


