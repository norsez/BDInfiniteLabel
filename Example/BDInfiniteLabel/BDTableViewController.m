//
//  BDTableViewController.m
//  BDInfiniteLabel
//
//  Created by Norsez Orankijanan on 3/2/15.
//  Copyright (c) 2015 Norsez Orankijanan. All rights reserved.
//

#import "BDTableViewController.h"
#import "BDInfiniteLabelTableViewCell.h"
@interface BDTableViewController ()
{
  NSArray *_data;
}
@end

@implementation BDTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  UINib *nib = [UINib nibWithNibName:@"BDInfiniteLabelTableViewCell" bundle:nil];
  [self.tableView registerNib:nib forCellReuseIdentifier:@"cellId"];
  
  _data = @[];
  
  for (int i = 0; i < 10; i++) {
    NSString* string = @"1234 ";
    NSInteger sentences = arc4random_uniform(3) + 2;
    for (int j = 0; j < sentences; j++) {
      string = [string stringByAppendingString:string];
    }
    NSAttributedString *astr = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20]}];
    _data = [_data arrayByAddingObject:astr];
  }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
  BDInfiniteLabelTableViewCell *bcell = (BDInfiniteLabelTableViewCell*)cell;
  
  bcell.infiniteLabel.attributedString = (NSAttributedString*) _data[indexPath.row];
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 58;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  BDTableViewController * nctrl =  [[BDTableViewController alloc] initWithStyle:0];
  [self.navigationController pushViewController:nctrl animated:YES];
}

@end
