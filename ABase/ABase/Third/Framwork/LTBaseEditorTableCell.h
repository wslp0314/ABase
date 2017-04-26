//
//  LTBaseEditorTableCell.h
//  LTFramework
//
//  Created by zty on 6/2/16.
//  Copyright © 2016 Lngtop. All rights reserved.
//

#import "LTBaseTableCell.h"

#import "LTProtocol.h"

@interface LTBaseEditorTableCell : LTBaseTableCell

@property (weak, nonatomic) id<LTBaseEditorTableCellDelegate> delegate;

@end
