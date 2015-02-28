//
//  ViewController.m
//  BDInfiniteLabel
//
//  Created by Norsez Orankijanan on 2/27/15.
//  Copyright (c) 2015 bluedot. All rights reserved.
//

#import "ViewController.h"
#import "BDInfiniteLabel.h"

#define kLyrics @"I want to be… I want to be. Someday I want to be. One shining star. Shine on where you are. Oh why. Oh why. My baby, won't you smile? I will not stop trying until your tears are dried."

@interface ViewController ()
@property (weak, nonatomic) IBOutlet BDInfiniteLabel *infiniteLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.infiniteLabel.attributedString = [self _longSampleText];
}


- (NSAttributedString*)_longSampleText
{
  NSMutableAttributedString* astr = [[NSMutableAttributedString alloc] initWithString:kLyrics attributes:@{}];
  
  NSArray* fonts = @[[UIFont systemFontOfSize:20], [UIFont systemFontOfSize:10], [UIFont boldSystemFontOfSize:15]];
  
  NSInteger lastIndex = 0;
  for (UIFont *f in fonts) {
    NSInteger len = MIN(arc4random_uniform(7), kLyrics.length);
    [astr setAttributes:@{NSFontAttributeName: f} range:(NSRange){lastIndex, len}];
    lastIndex += len;
  }
  
  return astr;
}


@end
