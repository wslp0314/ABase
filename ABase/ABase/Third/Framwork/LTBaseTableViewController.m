//
//  LTBaseTableViewController.m
//  LTFramework
//
//  Created by zty on 8/4/16.
//  Copyright © 2016 LNGTOP. All rights reserved.
//

#import "LTBaseTableViewController.h"

#import "LTBaseTableCell.h"
#import "LTBaseTableCellEntity.h"

@implementation LTBaseTableViewController

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataList[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [[[[self dataList] objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]] layoutHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LTBaseTableCellEntity *entity = [[[self dataList] objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    
    LTBaseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[entity reuseCellID]];
    [cell configureWithEntity:entity];
    [cell setDelegate:self];

    return cell;
}

@end
