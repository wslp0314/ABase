//
//  LPABaseMovieInfoManage.h
//  ABASE!!!
//
//  Created by wslp0314 on 2017/4/14.
//  Copyright © 2017年 abase. All rights reserved.
//

#import "LPConfig.h"
#import <hpple/TFHpple.h>

@interface LPABaseMovieInfoManage : NSObject
@property (strong, nonatomic) NSString *designation;
@property (strong, nonatomic) NSString *MovieInfoHTMLString;
@property (strong, nonatomic) NSMutableDictionary *movieInfoDic;
@property (strong, nonatomic) NSMutableArray *movieInfoArray;

+ (instancetype) aBaseMovieInfo;

- (void)getABaseMovieInfoDetailWithDesignation:(NSString *)designation completion:(void (^)(NSMutableDictionary *movieInfoDic))completion ;
@end
