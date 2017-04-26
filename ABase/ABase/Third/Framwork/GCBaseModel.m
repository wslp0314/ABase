//
//  GCBaseModel.m
//  GasChat
//
//  Created by Martin Yin on 12/4/2015.
//  Copyright © 2015 Lngtop. All rights reserved.
//

#import "GCBaseModel.h"
#import "GCCommons.h"

@implementation GCBaseModel
@synthesize jsonAdapter = _jsonAdapter;

+ (NSDictionary *)JSONKeyPathsByPropertyKey {

    return @{};
}

+ (MTLPropertyStorage)storageBehaviorForPropertyWithKey:(NSString *)propertyKey {
    if(![[[self JSONKeyPathsByPropertyKey] allKeys] containsObject:propertyKey]) {
        return MTLPropertyStorageNone;
    }

    return [super storageBehaviorForPropertyWithKey:propertyKey];
}

+ (NSValueTransformer *)gasTypeJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray<NSString *> *typeList, BOOL *success, NSError *__autoreleasing *error) {
        if(typeList.count == 1) {
            if([typeList.firstObject.lowercaseString isEqualToString:@"cng"]) {
                return @(GCGasTypeCNG);
            } else {
                return @(GCGasTypeLNG);
            }
        } else {
            return @(GCGasTypeAll);
        }
    }];
}

- (MTLJSONAdapter *)jsonAdapter {
    if(!_jsonAdapter) {
        _jsonAdapter = [[MTLJSONAdapter alloc] initWithModelClass:[self class]];
    }
    
    return _jsonAdapter;
}

- (instancetype)fillWithDictionary:(NSDictionary *)dictionary {
    NSError *error;
    [self mergeValuesForKeysFromModel:[self.jsonAdapter modelFromJSONDictionary:dictionary error:&error]];

    if (error) {
        
        DebugLog(@"mantle(failure): %@", error);
    }

    return self;
}

+ (instancetype)createWithDictionary:(NSDictionary *)dictionary {
    return [[[self alloc] init] fillWithDictionary:dictionary];
}

+ (NSValueTransformer *)integerToStringTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^NSString *(NSNumber *number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%@", number];
    } reverseBlock:^NSNumber *(NSString *string, BOOL *success, NSError *__autoreleasing *error) {
        return @([string integerValue]);
    }];
}

+ (NSValueTransformer *)floatToStringTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^NSString *(NSNumber *number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%f", number.floatValue];
    } reverseBlock:^NSNumber *(NSString *string, BOOL *success, NSError *__autoreleasing *error) {
        return @([string floatValue]);
    }];
}

+ (NSValueTransformer *)doubleToStringTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^NSString *(NSNumber *number, BOOL *success, NSError *__autoreleasing *error) {
        return [NSString stringWithFormat:@"%lf", number.doubleValue];
    } reverseBlock:^NSNumber *(NSString *string, BOOL *success, NSError *__autoreleasing *error) {
        return @([string doubleValue]);
    }];
}

+ (NSValueTransformer *)unixTimeStampToNSDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
    }];
}

@end

#if DEBUG

@implementation GCBaseModel (DebugTesting)

+ (void)debugTesting {
}

@end

#endif
