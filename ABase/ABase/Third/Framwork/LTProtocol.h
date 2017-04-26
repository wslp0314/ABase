//
//  LTProtocol.h
//  LTFramework
//
//  Created by zty on 9/9/16.
//
//

#ifndef LTProtocol_h
#define LTProtocol_h
#import <UIKit/UIKit.h>

@protocol LTBaseTableCellDelegate <NSObject>


@end

@protocol LTBaseEditorTableCellDelegate <LTBaseTableCellDelegate>

@optional
- (void)focusTextFieldInCell:(UITableViewCell *)cell cellEntity:(id)cellEntity;

- (void)editingChanged:(id)cellEntity;

@end

@protocol LTBaseTableCellEntityDelegate <NSObject>

- (id)dataEntity;

@end

@protocol LTBaseTableCellLayout <NSObject>

+ (CGFloat)layoutHeightWithEntity:(id)entity;

@end

@protocol LTBaseListModelDelegate <NSObject>

- (NSInteger)count;

- (BOOL)hasNext;

@end

#endif /* LTProtocol_h */
