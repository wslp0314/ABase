//
//  LPABaseInfoManage.h
//  ABASE!!!
//
//  Created by wslp0314 on 2017/4/12.
//  Copyright © 2017年 abase. All rights reserved.
//

#import "LPConfig.h"
#import <hpple/TFHpple.h>
#import "JGProgressHUD+MVExtension.h"

@interface LPABaseHomeInfoManage : NSObject
@property (strong, nonatomic) NSString *HomeHTMLString;
//@property (strong, nonatomic) NSMutableArray *movieInfoArray;
@property (strong, nonatomic) NSMutableDictionary *allMovieDic;
@property (strong, nonatomic) JGProgressHUD *hud;

+ (instancetype) aBaseHome;
- (void)getABaseHomeInfoCompletion:(void (^)(NSMutableDictionary *allMovieDic))completion;
@end
