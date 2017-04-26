//
//  LPABaseMovieInfoManage.m
//  ABASE!!!
//
//  Created by wslp0314 on 2017/4/14.
//  Copyright © 2017年 abase. All rights reserved.
//

#import "LPABaseMovieInfoManage.h"
#import "GCCommons.h"

@implementation LPABaseMovieInfoManage
+ (instancetype) aBaseMovieInfo {
    static dispatch_once_t once;
    static LPABaseMovieInfoManage *aBaseMovieInfoManage = nil;
    dispatch_once(&once, ^{
        aBaseMovieInfoManage = [[LPABaseMovieInfoManage alloc] init];
    });
    return aBaseMovieInfoManage;
}

- (void)getABaseMovieInfoDetailWithDesignation:(NSString *)designation completion:(void (^)(NSMutableDictionary *movieInfoDic))completion {
    [[GCCommons commons]showHudWith:@"正在加载数据..."];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *MovieUrl = [NSString stringWithFormat:@"%@%@",LPABaseURL,designation];
        //    NSString *retStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:MovieUrl] encoding:NSUTF8StringEncoding error:nil];
        NSString *retStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.abase.me/AAJ-024"] encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"%@",retStr);
        if (!retStr.length) {
            NSURL *url = [NSURL URLWithString:MovieUrl];
            NSData *data = [NSData dataWithContentsOfURL:url];
            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            
            retStr= [[NSString alloc] initWithData:data encoding:enc];
            NSLog(@"%@",retStr);
        }
        self.MovieInfoHTMLString = retStr;
        if (retStr.length) {
            [self getMovieDetailWithRetStr:retStr completion:^(NSMutableDictionary *movieInfoDic) {
                completion(movieInfoDic);
            }];
        } else {
            completion(nil);
        }
        
        
    });
    
}

//封面(名字,封面Url)
- (void) getMovieDetailWithRetStr:(NSString *)retStr completion:(void (^)(NSMutableDictionary *movieInfoDic))completion {
    NSData *dataTitle=[retStr dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *xpathParserImage = [[TFHpple alloc]initWithHTMLData:dataTitle];
    NSArray *elementTotalName = [xpathParserImage searchWithXPathQuery:@"//h3"];
    NSMutableArray *arrayTotalName = [NSMutableArray array];
    for (TFHppleElement *element in elementTotalName) {
        [arrayTotalName addObject:element.text?element.text:@""];
    }
   
    BOOL isHasMovieName = NO;
    BOOL isHasSource = NO;
    BOOL isHasAct = NO;
    BOOL isHasSnapshot = NO;
    BOOL isHasMovieDetailInfo = NO;
    for (NSString *str in arrayTotalName) {
        if ([str rangeOfString:@"快照图片"].location !=NSNotFound) {
            isHasSnapshot = YES;
        } else if ([str rangeOfString:@"帖子/种子/磁链/云播"].location !=NSNotFound) {
            isHasSource = YES;
        } else if ([str rangeOfString:@"影片描述"].location !=NSNotFound) {
            isHasMovieDetailInfo = YES;
        } else if ([str rangeOfString:@"\n"].location !=NSNotFound) {
            isHasAct = YES;
        } else {
            isHasMovieName = YES;
        }
    }
    self.movieInfoDic = [NSMutableDictionary dictionary];
    self.movieInfoArray = [NSMutableArray array];
    NSArray *arraySectionInfo = [retStr componentsSeparatedByString:@"<div class=\"panel panel-default\">"];
    if (arraySectionInfo.count) {
        if (isHasMovieName) {
            //封面section
            NSMutableDictionary *posterDic = [NSMutableDictionary dictionary];
            NSData *dataTitle=[arraySectionInfo[0] dataUsingEncoding:NSUTF8StringEncoding];
            TFHpple *xpathParserImage = [[TFHpple alloc]initWithHTMLData:dataTitle];
            NSArray *elementName = [xpathParserImage searchWithXPathQuery:@"//h3"];
            for (TFHppleElement *element in elementName) {
                //番剧名字
                [posterDic setObject:element.text?element.text:@"" forKey:@"movieName"];
            }
            NSArray *elementImage = [xpathParserImage searchWithXPathQuery:@"//img"];
            for (TFHppleElement *element in elementImage) {
                NSDictionary *elementContent =[element attributes];
                //番剧封面
                [posterDic setObject:elementContent[@"src"]?elementContent[@"src"]:@"" forKey:@"movieImage"];
            }
            //封面section 加入数组
            [self.movieInfoArray addObject:posterDic];
            [self.movieInfoDic setObject:posterDic forKey:@"movieName"];
        }
        
        
        if (isHasSnapshot) {
            //快照sectuon
            NSMutableDictionary *SnapshotsDic = [NSMutableDictionary dictionary];
            NSData *dataImages=[arraySectionInfo[1] dataUsingEncoding:NSUTF8StringEncoding];
            TFHpple *xpathParserImages = [[TFHpple alloc]initWithHTMLData:dataImages];
            NSArray *elementSnapshotName = [xpathParserImages searchWithXPathQuery:@"//h3"];
            for (TFHppleElement *element in elementSnapshotName) {
                //快照名字
                [SnapshotsDic setObject:element.text?element.text:@"" forKey:@"movieSnapshotName"];
            }
            NSArray *elementSnapshot = [xpathParserImages searchWithXPathQuery:@"//img"];
            NSMutableArray *thumbArray = [NSMutableArray array];
            for (TFHppleElement *element in elementSnapshot) {
                NSDictionary *elementContent =[element attributes];
                //快照加入数组
                [thumbArray addObject:elementContent[@"src"]?elementContent[@"src"]:@""];
            }
            NSArray *elementSnapshotDetail = [xpathParserImages searchWithXPathQuery:@"//a"];
            NSMutableArray *detailArray = [NSMutableArray array];
            for (TFHppleElement *element in elementSnapshotDetail) {
                NSDictionary *elementContent =[element attributes];
                //快照加入数组
                [detailArray addObject:elementContent[@"href"]?elementContent[@"href"]:@""];
            }
            //快照sectuon 加入数组
            NSMutableArray *arraySnapshots = [NSMutableArray array];
            for (int i = 0; i < thumbArray.count; i++) {
                NSDictionary *dic = @{@"thumbSnapshotUrl"  : thumbArray[i] ,
                                      @"detailSnapshotUrl" : detailArray[i]
                                      };
                [arraySnapshots addObject:dic];
            }
            [SnapshotsDic setObject:arraySnapshots forKey:@"snapshotUrlArray"];
            [self.movieInfoArray addObject:SnapshotsDic];
            [self.movieInfoDic setObject:SnapshotsDic forKey:@"movieSnapshots"];
        }
        
        
        if (isHasSource) {
            //资源sectuon
            NSMutableDictionary *sourcesDic = [NSMutableDictionary dictionary];
            NSData *dataSources=[arraySectionInfo[2] dataUsingEncoding:NSUTF8StringEncoding];
            TFHpple *xpathParserSources = [[TFHpple alloc]initWithHTMLData:dataSources];
            NSArray *elementSourcesName = [xpathParserSources searchWithXPathQuery:@"//h3"];
            for (TFHppleElement *element in elementSourcesName) {
                //资源名字
                [sourcesDic setObject:element.text?element.text:@"" forKey:@"sourceName"];
            }
            NSArray *elementSourceTime = [xpathParserSources searchWithXPathQuery:@"//li"];
            NSMutableArray *sourceTimeArray = [NSMutableArray array];
            for (TFHppleElement *element in elementSourceTime) {
                //资源时间加入数组
                NSString *str;
                if (element.text.length) {
                    str = element.text;
                    str = [str stringByReplacingOccurrencesOfString:@"\n"withString:@""];
                    str = [str stringByReplacingOccurrencesOfString:@" "withString:@""];
                }
                [sourceTimeArray addObject:str?str:@""];
            }
            NSArray *elementSourceName = [xpathParserSources searchWithXPathQuery:@"//a"];
            NSMutableArray *sourceNameArray = [NSMutableArray array];
            for (TFHppleElement *element in elementSourceName) {
                NSDictionary *elementContent =[element attributes];
                NSDictionary *dic = @{@"sourceName" : element.text?element.text:@"",
                                      @"sourceUrl"  : elementContent[@"href"]?elementContent[@"href"]:@""
                                      };
                [sourceNameArray addObject:dic];
            }
            NSMutableArray *arraySource = [NSMutableArray array];
            for (int i = 0; i < sourceNameArray.count; i++) {
                NSDictionary *dic = sourceNameArray[i];
                NSMutableDictionary *dicM = [NSMutableDictionary dictionaryWithDictionary:dic];
                [dicM setObject:sourceTimeArray[i] forKey:@"sourceTime"];
                [arraySource addObject:dicM];
            }
            [sourcesDic setObject:arraySource forKey:@"sourceArray"];
            //资源sectuon 加入数组
            [self.movieInfoArray addObject:sourcesDic];
            [self.movieInfoDic setObject:sourcesDic forKey:@"movieSources"];
        }
        
        
        
        //演员列表section
        NSMutableArray *allInfoArray = [NSMutableArray arrayWithArray:arraySectionInfo];
        NSMutableArray *actInfoArray = [NSMutableArray array];

        if (isHasAct) {
            if (isHasMovieName) {
                [allInfoArray removeObjectAtIndex:0];
            }
            if (isHasSnapshot) {
                [allInfoArray removeObjectAtIndex:0];
            }
            if (isHasSource) {
                [allInfoArray removeObjectAtIndex:0];
            }
            if (isHasMovieName) {
                [allInfoArray removeLastObject];
            }
        
        
            for (NSString *str in allInfoArray) {
                NSData *dataTitle=[str dataUsingEncoding:NSUTF8StringEncoding];
                TFHpple *xpathParserActUrl = [[TFHpple alloc]initWithHTMLData:dataTitle];
                NSArray *elementActUrl = [xpathParserActUrl searchWithXPathQuery:@"//a"];
                NSMutableDictionary *actDic = [NSMutableDictionary dictionary];
                for (TFHppleElement *element in elementActUrl) {
                    NSDictionary *elementContent =[element attributes];
                    [actDic setObject:elementContent[@"href"]?elementContent[@"href"]:@"" forKey:@"actUrl"];
                }
                NSArray *elementActName = [xpathParserActUrl searchWithXPathQuery:@"//img"];
                for (TFHppleElement *element in elementActName) {
                    NSDictionary *elementContent =[element attributes];
                    [actDic setObject:elementContent[@"src"]?elementContent[@"src"]:@"" forKey:@"actIconUrl"];
                    [actDic setObject:elementContent[@"title"]?elementContent[@"title"]:@"" forKey:@"actName"];
                }
                NSArray *elementActDetailTitle = [xpathParserActUrl searchWithXPathQuery:@"//p"];
                NSMutableArray *actDetailTitle = [NSMutableArray array];
                for (TFHppleElement *element in elementActDetailTitle) {
                    NSString *str;
                    if (element.text.length) {
                        str = [element.text stringByReplacingOccurrencesOfString:@"&nbsp"withString:@""];
                    }
                    [actDetailTitle addObject:str?str:@""];
                }
                NSArray *elementActDetail = [xpathParserActUrl searchWithXPathQuery:@"//strong"];
                NSMutableArray *actDetail = [NSMutableArray array];
                for (TFHppleElement *element in elementActDetail) {
                    [actDetail addObject:element.text?element.text:@""];
                }
                NSMutableString *actInfoStr = [NSMutableString string];
                for (int i = 0; i < actDetailTitle.count; i++) {
                    [actInfoStr appendString:actDetailTitle[i]];
                    [actInfoStr appendString:actDetail[i]];
                    [actInfoStr appendString:@"\n"];
                }
                [actDic setObject:actInfoStr forKey:@"actInfoStr"];
                [actInfoArray addObject:actDic];
            }
            NSMutableDictionary *actDic = [NSMutableDictionary dictionary];
            [actDic setObject:actInfoArray forKey:@"actInfoArray"];
            [self.movieInfoDic setObject:actInfoArray forKey:@"movieActorArray"];
            [self.movieInfoArray addObject:actInfoArray];
        }
        
        //电影描述section
        if (isHasMovieDetailInfo) {
            //资源sectuon
            NSMutableDictionary *movieDetailDic = [NSMutableDictionary dictionary];
            NSData *dataSources=[arraySectionInfo.lastObject dataUsingEncoding:NSUTF8StringEncoding];
            TFHpple *xpathParserMovieDetail = [[TFHpple alloc]initWithHTMLData:dataSources];
            NSArray *elementSourcesName = [xpathParserMovieDetail searchWithXPathQuery:@"//div"];
            for (TFHppleElement *element in elementSourcesName) {
                //电影简介
                if ([[element objectForKey:@"class"] isEqualToString:@"panel-body text-left"]) {
                    [movieDetailDic setObject:element.text?element.text:@"" forKey:@"movieIntroduce"];
                }
            }
            NSArray *elementMovieDetailTitle = [xpathParserMovieDetail searchWithXPathQuery:@"//p"];
            NSMutableArray *movieDetailTitle = [NSMutableArray array];
            for (TFHppleElement *element in elementMovieDetailTitle) {
                NSString *str;
                if (element.text.length) {
                    str = [element.text stringByReplacingOccurrencesOfString:@"&nbsp"withString:@""];
                    str = [str stringByReplacingOccurrencesOfString:@"\n"withString:@""];
                    str = [str stringByReplacingOccurrencesOfString:@" "withString:@""];
                }
                [movieDetailTitle addObject:str?str:@""];
            }
            NSArray *elementMovieDetail = [xpathParserMovieDetail searchWithXPathQuery:@"//strong"];
            NSMutableArray *movieDetail = [NSMutableArray array];
            for (TFHppleElement *element in elementMovieDetail) {
                [movieDetail addObject:element.text?element.text:@""];
            }
            NSMutableString *movieInfoStr = [NSMutableString string];
            for (int i = 0; i < movieDetailTitle.count - 1; i++) {
                [movieInfoStr appendString:movieDetailTitle[i]];
                [movieInfoStr appendString:movieDetail[i]];
                [movieInfoStr appendString:@"\n"];
            }
            NSArray *elementMovieStytle = [xpathParserMovieDetail searchWithXPathQuery:@"//a"];
            NSMutableArray *arrayMovieStyle = [NSMutableArray array];
            for (TFHppleElement *element in elementMovieStytle) {
                if ([[element objectForKey:@"class"] isEqualToString:@"genre2"]) {
                    NSDictionary *elementContent =[element attributes];
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [dic setObject:element.text?element.text:@"" forKey:@"movieStyle"];
                    [dic setObject:elementContent[@"href"]?elementContent[@"href"]:@"" forKey:@"movieStyleUrl"];
                    [arrayMovieStyle addObject:dic];
                }
            }
            [movieDetailDic setObject:movieInfoStr forKey:@"movieInfoStr"];
            [movieDetailDic setObject:arrayMovieStyle forKey:@"movieStyleArray"];
            [self.movieInfoArray addObject:movieDetailDic];
            [self.movieInfoDic setObject:movieDetailDic forKey:@"movieDetail"];

        }

    }
    dispatch_async(dispatch_get_main_queue(), ^{
        completion(self.movieInfoDic);
    });
    
}

@end

