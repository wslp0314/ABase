//
//  LPABaseInfoManage.m
//  ABASE!!!
//
//  Created by wslp0314 on 2017/4/12.
//  Copyright © 2017年 abase. All rights reserved.
//

#import "LPABaseHomeInfoManage.h"
#import "GCCommons.h"

@implementation LPABaseHomeInfoManage

+ (instancetype) aBaseHome {
    static dispatch_once_t once;
    static LPABaseHomeInfoManage *aBaseHomeInfoManage = nil;
    dispatch_once(&once, ^{
        aBaseHomeInfoManage = [[LPABaseHomeInfoManage alloc] init];
    });
    return aBaseHomeInfoManage;
}

- (void)getABaseHomeInfoCompletion:(void (^)(NSMutableDictionary *allMovieDic))completion {
    
    [[GCCommons commons] showHudWith:@"正在加载数据..."];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *homeUrl = [NSString stringWithFormat:@"%@",LPABaseURL];
        NSString *retStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:homeUrl] encoding:NSUTF8StringEncoding error:nil];
        
        if (!retStr.length) {
            NSURL *url = [NSURL URLWithString:homeUrl];
            NSData *data = [NSData dataWithContentsOfURL:url];
            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            retStr = [[NSString alloc] initWithData:data encoding:enc];
            NSLog(@"%@",retStr);
        }
        NSLog(@"%@",retStr);
        
        self.HomeHTMLString = retStr;
        if (retStr.length) {
            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"aBaseCategory"]) {
                [self getABaseCategoryAndSaveWith:retStr];
            }
            [self getABaseMovieInfoWith:retStr completion:^(NSMutableDictionary *allMovieDic) {
                completion(allMovieDic);
            }];
        }
    });
    
}




//获取abase分类
- (void)getABaseCategoryAndSaveWith:(NSString *)retStr  {
    NSArray *arrayPage = [retStr componentsSeparatedByString:@"<div class=\"list-inline genrepanel\">"];
    NSMutableArray *arrayM = [arrayPage mutableCopy];
    [arrayM removeObjectAtIndex:0];
    NSMutableArray *allCategoryArray = [NSMutableArray array];
    NSMutableArray *totalCategoryArray = [NSMutableArray array];
    NSMutableArray *subCategoryArray = [NSMutableArray array];
    for (NSString *str in arrayM) {
        NSData *dataTitle=[str dataUsingEncoding:NSUTF8StringEncoding];
        TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:dataTitle];
        NSArray *elements = [xpathParser searchWithXPathQuery:@"//span"];
        for (TFHppleElement *element in elements) {
            
            if ([[element objectForKey:@"class"] isEqualToString:@"group"]) {
                [totalCategoryArray addObject:element.text];
            }
        }
    }
    NSArray *arrayTotal = [arrayM.firstObject componentsSeparatedByString:@"<span class=\"group\">"];
    for (NSString *str in arrayTotal) {
        NSData *dataTitle=[str dataUsingEncoding:NSUTF8StringEncoding];
        TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:dataTitle];
        NSArray *elements = [xpathParser searchWithXPathQuery:@"//a"];
        NSMutableArray *nodePropertyArray = [NSMutableArray array];
        for (TFHppleElement *element in elements) {
            NSMutableDictionary *nodePropertyDic = [NSMutableDictionary dictionary];
            NSDictionary *elementContent =[element attributes];
            if (elementContent[@"id"]) {
                [nodePropertyDic setObject:element.text forKey:@"categoryName"];
                [nodePropertyDic setObject:elementContent[@"id"] forKey:@"categoryId"];
                [nodePropertyArray addObject:nodePropertyDic];
            }
        }
        if (nodePropertyArray.count) {
            [subCategoryArray addObject:nodePropertyArray];
        }
    }
    for (int i = 0; i < totalCategoryArray.count; i++) {
        NSMutableDictionary *categoryDic = [NSMutableDictionary dictionary];
        [categoryDic setObject:totalCategoryArray[i] forKey:@"totalCategoryName"];
        [categoryDic setObject:subCategoryArray[i] forKey:@"subCategorys"];
        [allCategoryArray addObject:categoryDic];
    }
    NSDictionary *dic = @{@"aBaseCategory":allCategoryArray};

    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"aBaseCategory"];
}

//获取abasevideo信息
- (void)getABaseMovieInfoWith:(NSString *)retStr
                   completion:(void (^)(NSMutableDictionary *allMovieDic))completion
{
    self.allMovieDic = [NSMutableDictionary dictionary];
    NSArray *arrayPage = [retStr componentsSeparatedByString:@"<div class=\"item pull-left\">"];
    NSMutableArray *arrayM = [arrayPage mutableCopy];
    [arrayM removeObjectAtIndex:0];
    NSMutableArray *movieInfoArray = [NSMutableArray array];
    for (NSString *str in arrayM) {
        NSData *dataTitle=[str dataUsingEncoding:NSUTF8StringEncoding];
        TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:dataTitle];
        NSMutableDictionary *nodePropertyDic = [NSMutableDictionary dictionary];
        //番号,分类(有种,无种  和  中文字幕),时间
        NSArray *elements = [xpathParser searchWithXPathQuery:@"//span"];
        for (TFHppleElement *element in elements) {
            //有种,无种
            if ([[element objectForKey:@"class"] isEqualToString:@"badge badge-success"]) {
                [nodePropertyDic setObject:element.text?element.text:@"" forKey:@"seedState"];
            }
            //中文字幕
            if ([[element objectForKey:@"class"] isEqualToString:@"badge badge-info"]) {
                [nodePropertyDic setObject:element.text?element.text:@"" forKey:@"subtitles"];
            }
            //时间
            if ([[element objectForKey:@"style"] isEqualToString:@"float:right"]&&[[element objectForKey:@"class"] isEqualToString:@"infofooter"]) {
                [nodePropertyDic setObject:element.text?element.text:@"" forKey:@"releaseTime"];
            }
        }
        
        if (!nodePropertyDic[@"seedState"]){
            [nodePropertyDic setObject:@"" forKey:@"seedState"];
        }
        if (!nodePropertyDic[@"subtitles"]){
            [nodePropertyDic setObject:@"" forKey:@"subtitles"];
        }
        
        //图片链接
        NSArray *elementImgArray = [xpathParser searchWithXPathQuery:@"//img"];
        for (TFHppleElement *element in elementImgArray) {
            NSDictionary *elementContent =[element attributes];
            if (elementContent[@"data-original"]) {
                [nodePropertyDic setObject:elementContent[@"data-original"]?elementContent[@"data-original"]:@"" forKey:@"iconUrl"];
            }
        }
        //名字,番号,演员S,归属类别(plist文件)
        NSArray *elementArr = [xpathParser searchWithXPathQuery:@"//a"];
        NSMutableArray *actorArray = [NSMutableArray array];
        NSMutableArray *genreArray = [NSMutableArray array];
        for (TFHppleElement *element in elementArr) {
            NSDictionary *elementContent =[element attributes];
            if ([[element objectForKey:@"target"] isEqualToString:@"_blank"]) {
                [nodePropertyDic setObject:element.text?element.text:@"" forKey:@"movieName"];
                [nodePropertyDic setObject:elementContent[@"href"]?elementContent[@"href"]:@"" forKey:@"designation"];
            }
            NSMutableDictionary *actorDic = [NSMutableDictionary dictionary];
            if ([[element objectForKey:@"class"] isEqualToString:@"actor"]) {
                [actorDic setObject:element.text forKey:@"actorName"];
                [actorDic setObject:[element attributes][@"href"] forKey:@"actorAllMovieUrl"];
                [actorArray addObject:actorDic];
            }
            NSMutableDictionary *genreDic = [NSMutableDictionary dictionary];
            if ([[element objectForKey:@"class"] isEqualToString:@"genre2"]) {
                [genreDic setObject:element.text forKey:@"genre"];
                NSDictionary *elementContent =[element attributes];
                [genreDic setObject:elementContent[@"href"] forKey:@"genreUrl"];
                [genreArray addObject:genreDic];
            }
        }
        if (!actorArray.count) {
            [nodePropertyDic setObject:@"" forKey:@"actors"];
        } else {
            [nodePropertyDic setObject:actorArray forKey:@"actors"];
        }
        if (!genreArray.count) {
            [nodePropertyDic setObject:@"" forKey:@"genres"];
        } else {
            [nodePropertyDic setObject:genreArray forKey:@"genres"];
        }
        [movieInfoArray addObject:nodePropertyDic];
    }
    [self.allMovieDic setObject:movieInfoArray forKey:@"movieInfoArray"];
    if ([[arrayPage lastObject] componentsSeparatedByString:@"<nav class=\"navbar-fixed-bottom text-center\">"].count > 1) {
        NSData *dataTitle=[[[[arrayPage lastObject] componentsSeparatedByString:@"<nav class=\"navbar-fixed-bottom text-center\">"]lastObject] dataUsingEncoding:NSUTF8StringEncoding];
        TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:dataTitle];
        NSArray *elements = [xpathParser searchWithXPathQuery:@"//a"];
        for (TFHppleElement *element in elements) {
            if ([[element objectForKey:@"style"] isEqualToString:@"background-color: #444"]) {
                NSDictionary *elementContent =[element attributes];
                NSString *str = element.text;
                if ([str rangeOfString:@"首页"].location !=NSNotFound) {
                    [self.allMovieDic setObject:elementContent[@"href"]?elementContent[@"href"]:@"" forKey:@"homePageUrl"];
                } else if ([str rangeOfString:@"上一页"].location !=NSNotFound) {
                    [self.allMovieDic setObject:elementContent[@"href"]?elementContent[@"href"]:@"" forKey:@"PreviousPageUrl"];
                } else if ([str rangeOfString:@"下一页"].location !=NSNotFound) {
                    [self.allMovieDic setObject:elementContent[@"href"]?elementContent[@"href"]:@"" forKey:@"nextPageUrl"];
                }
            }
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        completion(self.allMovieDic);
    });
}


@end
