//
//  NSArray+GCExtension.m
//  GasChat
//
//  Created by Martin Yin on 3/26/2016.
//  Copyright © 2016 Lngtop. All rights reserved.
//

#import "NSArray+GCExtension.h"

@implementation NSArray (GCExtension)

- (NSArray *)mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block {
//    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
    NSMutableArray *result = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id mapObject = block(obj, idx);
        if(mapObject) {
            [result addObject:mapObject];
        }
    }];
    
    return result;
}

- (NSArray *)filterObjectsUsingBlock:(BOOL (^)(id obj, NSUInteger idx))block {
    NSIndexSet *indexSet = [self indexesOfObjectsPassingTest:^BOOL(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return block(obj, idx);
    }];

    return (indexSet.count > 0) ? [self objectsAtIndexes:indexSet] : [NSArray array];
}

@end
