//
//  NSArray+GCExtension.h
//  GasChat
//
//  Created by Martin Yin on 3/26/2016.
//  Copyright © 2016 Lngtop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (GCExtension)

- (NSArray *)mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block;

- (NSArray *)filterObjectsUsingBlock:(BOOL (^)(id obj, NSUInteger idx))block;

@end
