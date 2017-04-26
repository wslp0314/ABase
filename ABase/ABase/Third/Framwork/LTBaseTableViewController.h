//
//  LTBaseTableViewController.h
//  LTFramework
//
//  Created by zty on 8/4/16.
//  Copyright © 2016 LNGTOP. All rights reserved.
//

#import "LTBaseViewController.h"

#import "LTProtocol.h"

@interface LTBaseTableViewController : LTBaseViewController <LTBaseTableCellDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataList;

@end
