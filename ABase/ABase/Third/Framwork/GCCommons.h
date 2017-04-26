//
//  GCCommons.h
//  GasChat
//
//  Created by Martin Yin on 12/2/2015.
//  Copyright © 2015 Lngtop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "JGProgressHUD+MVExtension.h"

#define LogToFile 1

#if LogToFile
    #define DebugLog(s, ...) [[GCFileLogger logger] log:s, ##__VA_ARGS__]
#else
    #if defined(DEBUG)
    #define DebugLog(s, ...) NSLog(s, ##__VA_ARGS__)
    #else
    #define DebugLog(s, ...)
    #endif
#endif

extern NSString * const kLPBaseURL;
extern NSString * const kLPTestURL;
extern NSString * const kLPUserInfo;
extern NSString * const kLPLoginSccess;
extern NSString * const kLPAppkey;
extern NSString * const kLPAppSecret;
extern NSString * const kLPShowLoginView;
extern NSString * const KLPKeyOffset;
extern NSString * const kLPCodeCountDown;
extern NSString * const kLPHideHud;
extern NSString * const kLPJPushAppID;
extern NSString * const kLPJPushChannel;
extern NSString * const kLPDeviceSettingChangeID;
extern NSString * const kLPDeviceSettingParameter;
extern NSString * const kLPCarInfo;
extern NSString * const kLPPhoneNum;
extern NSString * const kLPJpushInfo;
extern NSString * const kLPP2pID;
extern BOOL       const kLPJPushIsProduction;
extern NSUInteger const kLPCellHeight;


@interface GCCommons : NSObject
@property (assign, nonatomic) BOOL freeTrial;
@property (assign, nonatomic) BOOL isCancel;
@property (assign, nonatomic) BOOL isLogin;
@property (assign, nonatomic) BOOL isJpush;
@property (assign, nonatomic) BOOL isJpushWhenAppRunning;
@property (strong, nonatomic) NSString *p2pID;
@property (strong, nonatomic) NSString *freeP2pID;
@property (strong, nonatomic) NSDictionary *JpushInfo;
@property (assign, nonatomic) BOOL nineViewSwitchBtnIsOn;
@property (assign, nonatomic) BOOL touchIDSwitchBtnIsOn;
@property (strong, nonatomic) JGProgressHUD *hud;

- (void) showHudWith:(NSString *)text;
- (void) hideHud;
- (void) showSuccessHudWith:(NSString *)text;
- (void) showErrorHudWith:(NSString *)text;

+ (instancetype)commons;
+ (BOOL)hasUserInfoBefore;
+ (BOOL)hasGesturePasswordBefore;
+ (BOOL)hasLoginUseNineViewState;
+ (BOOL)getLoginUseNineViewState;
+ (BOOL)getLoginTouchIDViewState;
+ (NSString *) getUserId;

+ (NSString *)getP2pID;
+ (NSString *)getKLPP2pID;

+ (NSString *)getGesturePassword;
+ (NSDictionary *)getGesturePasswordDic;
+ (NSDictionary *)getUserDefaultDicWithKey:(NSString *)key;
+ (void)saveGesturePassDicWith:(NSDictionary *)dic;

+ (void)saveP2pIDWithUserId:(NSString *)userId andP2pIDDic:(NSDictionary *)dic;//登陆时候保存之前的p2pID
//判断当前网络状态
+ (NSString *)getNetWorkStates;
@end

/* Return a random integer number between low and high inclusive */
int randomInt(int low, int high);

/* Return a random BOOL value */
BOOL randomBool();

/* Return a random float between 0.0 and 1.0 */
float randomClamp();

/* Get top viewController */
UIViewController *AppRootTopViewController();

/* return the distance of two points */
float distance(CLLocationCoordinate2D location1, CLLocationCoordinate2D location2);

/* call With number */
void callPhoneNumber(NSString *phoneNumber, UIViewController *vc);

/* check if the string is valid presentation of float number */
BOOL isValidFloatNumberString(NSString *string);

/* string to price int value conversion */
NSUInteger priceIntegerValueFromString(NSString *string);

#if LogToFile
@interface GCFileLogger: NSObject

+ (instancetype)logger;
- (void)log:(NSString *)format, ...;

@end
#endif
