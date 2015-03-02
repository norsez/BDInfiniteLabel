//
//  BDAppDelegate.m
//  BDInfiniteLabel
//
//  Created by CocoaPods on 03/02/2015.
//  Copyright (c) 2014 Norsez Orankijanan. All rights reserved.
//

#import "BDAppDelegate.h"
#import "BDTableViewController.h"

@implementation BDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController: [[BDTableViewController alloc] initWithStyle:0]];
  [self.window makeKeyAndVisible];
  return YES;
}
@end
