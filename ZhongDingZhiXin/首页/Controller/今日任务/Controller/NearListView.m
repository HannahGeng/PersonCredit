//
//  NearListView.m
//  个人职业信用
//
//  Created by zdzx-008 on 16/7/26.
//  Copyright © 2016年 北京职信鼎程. All rights reserved.
//

#import "NearListView.h"

@interface NearListView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *nearTableView;

@end

@implementation NearListView

- (IBAction)closeClick {

    FDAlertView *alert = (FDAlertView *)self.superview;
    [alert hide];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppShare;
    return app.nearArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppShare;
    
    NearCell * cell = [NearCell cellWithTableView:tableView];
    cell.textLabel.text = [NSString stringWithFormat:@"text----%ld",indexPath.row];
    cell.backgroundColor = [UIColor greenColor];
    cell.nearmodel = app.nearArray[indexPath.row];
    
    return cell;
}

@end
