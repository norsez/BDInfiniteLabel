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
  
  NSString* path = [[NSBundle mainBundle] pathForResource:@"newsheadlines" ofType:@"plist"];
  NSData* fd = [[NSData alloc] initWithContentsOfFile:path];
  NSDictionary* plist = [NSPropertyListSerialization propertyListWithData:fd options:0 format:0 error:0];
  _data = [plist valueForKey:@"items"];
  _data = [_data sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
    //shuffle
    return arc4random_uniform(2) % 2 == 1? NSOrderedAscending: NSOrderedDescending;
  }];
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
  
  bcell.infiniteLabel.attributedString = [[NSAttributedString alloc] initWithString: _data[indexPath.row] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20], NSForegroundColorAttributeName: [UIColor blackColor]}];
  //bcell.infiniteLabel.hasMoreButtonHidden = arc4random() % 2 == 1;
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
