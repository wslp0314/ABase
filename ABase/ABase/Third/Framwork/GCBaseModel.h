//
//  GCBaseModel.h
//  GasChat
//
//  Created by Martin Yin on 12/4/2015.
//  Copyright © 2015 Lngtop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mantle.h"

//#import "GCNetwork.h"

typedef BOOL(^GCGetDataValidation)(id __nonnull data);
typedef void(^GCGetDataSuccess)(id __nonnull data);
typedef void(^GCGetDataFailure)(NSURLRequest * __nullable request, NSHTTPURLResponse * __nullable response, id __nullable data, NSError * __nullable error);

typedef void(^GCUploadAppendBodyPart)(NSData * __nonnull data, NSString * __nonnull name, NSString * __nullable fileName);
typedef BOOL(^GCUploadMultipartFiller)(GCUploadAppendBodyPart __nonnull appendBlock);

typedef void(^GCUrlBuilderComplete)(NSString * __nonnull urlString);

typedef NS_ENUM(NSUInteger, GCGasType) {
    GCGasTypeAll,
    GCGasTypeLNG,
    GCGasTypeCNG,
    GCGasTypeNone,
};

@interface GCBaseModel : MTLModel <MTLJSONSerializing>

@property (nonnull, strong, nonatomic, readonly) MTLJSONAdapter *jsonAdapter;

- (nullable instancetype)fillWithDictionary:(nonnull NSDictionary *)dictionary;

+ (nullable instancetype)createWithDictionary:(nonnull NSDictionary *)dictionary;

+ (nonnull NSValueTransformer *)integerToStringTransformer;
+ (nonnull NSValueTransformer *)floatToStringTransformer;
+ (nonnull NSValueTransformer *)doubleToStringTransformer;

+ (nonnull NSValueTransformer *)gasTypeJSONTransformer;
+ (nonnull NSValueTransformer *)unixTimeStampToNSDateJSONTransformer;

@end

#if DEBUG

@interface GCBaseModel (DebugTesting)

+ (void)debugTesting;

@end

#endif
