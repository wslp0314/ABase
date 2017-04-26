//
//  LPABaseHomeViewController.m
//  ABASE!!!
//
//  Created by wslp0314 on 2017/4/12.
//  Copyright © 2017年 abase. All rights reserved.
//

#import "LPABaseHomeViewController.h"
#import "LPABaseHomeInfoManage.h"
#import "LPABaseMovieInfoManage.h"
#import "LPSubCategoryName.h"
#import "LPMovieSimpleInfo.h"
#import "GCCommons.h"
#import "LPMovieInfoModel.h"

@interface LPABaseHomeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *TextView;

@end

@implementation LPABaseHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //同测试字典转模型LPMovieSimpleInfo
//    [[LPABaseHomeInfoManage aBaseHome] getABaseHomeInfoCompletion:^(NSMutableDictionary *allMovieDic) {
//        [[LPPageInfo pageInfo] pageInfoToModel:allMovieDic completion:^(LPPageInfo *pageInfo, NSDictionary *dic, NSError *error) {
//            self.TextView.text = pageInfo.nextPageUrl;
//            [[GCCommons commons] hideHud];
//        }];
//    }];
    
    //测试字典转模型categoryNameList
//    [[LPCategoryNameList  categoryNameList] categoryNameListToModel:[[NSUserDefaults standardUserDefaults] objectForKey:@"aBaseCategory"] completion:^(LPCategoryNameList *categoryNameList, NSDictionary *dic, NSError *error) {
//        
//    }];
    
    //测试字典转模型LPmovieInfoDic
    [[LPABaseMovieInfoManage aBaseMovieInfo] getABaseMovieInfoDetailWithDesignation:nil completion:^(NSMutableDictionary *movieInfoDic) {
//
        [[LPMovieInfoModel movieInfoModel]movieInfoToModel:movieInfoDic completion:^(LPMovieInfoModel *movieInfoModel, NSDictionary *dic, NSError *error) {
            [[GCCommons commons] hideHud];
            [[GCCommons commons] showSuccessHudWith:@"加载成功"];
        }];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
