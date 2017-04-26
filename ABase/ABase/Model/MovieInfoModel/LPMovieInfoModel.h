//
//  LPMovieInfoModel.h
//  ABASE!!!
//
//  Created by wslp0314 on 2017/4/22.
//  Copyright © 2017年 abase. All rights reserved.
//

#import "GCBaseModel.h"
@interface LPMovieActor : GCBaseModel
@property (strong, nonatomic) NSString *actUrl;
@property (strong, nonatomic) NSString *actIconUrl;
@property (strong, nonatomic) NSString *actInfoStr;
@property (strong, nonatomic) NSString *actName;
@end

@interface LPMovieSnapshotUrl : GCBaseModel
@property (strong, nonatomic) NSString *thumbSnapshotUrl;
@property (strong, nonatomic) NSString *detailSnapshotUrl;
@end

@interface LPMovieSourceInfo : GCBaseModel
@property (strong, nonatomic) NSString *sourceTime;
@property (strong, nonatomic) NSString *sourceName;
@property (strong, nonatomic) NSString *sourceUrl;
@end

@interface LPMovieStyleInfo :GCBaseModel
@property (strong, nonatomic) NSString *movieStyleStr;
@property (strong, nonatomic) NSString *movieStyleUrl;
@end

@interface LPMovieName : GCBaseModel
@property (strong, nonatomic) NSString *movieName;
@property (strong, nonatomic) NSString *movieImage;
@end

@interface LPMovieSnapshots : GCBaseModel
@property (strong, nonatomic) NSString *movieSnapshotName;
@property (strong, nonatomic) NSArray <LPMovieSnapshotUrl *>* snapshotUrlList;
@end

@interface LPMovieSources : GCBaseModel
@property (strong, nonatomic) NSString *sourceName;
@property (strong, nonatomic) NSArray <LPMovieSourceInfo *>*sourceList;
@end

@interface LPMovieActorList : GCBaseModel
@property (strong, nonatomic) NSArray <LPMovieActor *>* movieActorList;
@end

@interface LPMovieDetail : GCBaseModel
@property (strong, nonatomic) NSString *movieIntroduce;
@property (strong, nonatomic) NSString *movieInfoStr;
@property (strong, nonatomic) NSArray <LPMovieStyleInfo *>*movieStyleList;
@end

@interface LPMovieInfoModel : GCBaseModel
@property (strong, nonatomic) LPMovieName *movieName;
@property (strong, nonatomic) LPMovieSnapshots *movieSnapshots;
@property (strong, nonatomic) LPMovieSources *movieSources;
@property (strong, nonatomic) LPMovieActorList *movieActorList;
@property (strong, nonatomic) LPMovieDetail *movieDetail;

+ (instancetype) movieInfoModel;

- (void)movieInfoToModel:(NSDictionary *)dic completion:(void (^)(LPMovieInfoModel *movieInfoModel, NSDictionary *dic, NSError *error))completion;
@end
