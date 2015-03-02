//
//  BDInfiniteLabel.m
//  BDInfiniteLabel
//
//  Created by Norsez Orankijanan on 2/27/15.
//  Copyright (c) 2015 bluedot. All rights reserved.
//

#import "BDInfiniteLabel.h"
@interface BDInfiniteLabel () <UIScrollViewDelegate>
{
  UIScrollView* _scrollView;
  UILabel *_label;
  UIButton *_navButton;
  NSInteger _currentPage;
}


@end

@implementation BDInfiniteLabel

- (void)_initialize
{
  self.backgroundColor = [UIColor clearColor];
  _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
  _scrollView.delegate = self;
  _scrollView.backgroundColor = [UIColor clearColor];
  _scrollView.showsVerticalScrollIndicator = NO;
  _scrollView.showsHorizontalScrollIndicator = NO;
  _scrollView.decelerationRate = UIScrollViewDecelerationRateNormal * 0.05;
  _scrollView.scrollEnabled = NO;
  _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  _label = [[UILabel alloc] initWithFrame:CGRectZero];
  _label.numberOfLines = 1;
  _label.lineBreakMode = NSLineBreakByClipping;
  _label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
  
  _navButton = [[UIButton alloc] initWithFrame:CGRectZero];
  _navButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  _navButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.25];
  _navButton.alpha = 0.45;
  [_navButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [_navButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"…" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14], NSForegroundColorAttributeName: [UIColor whiteColor]}]  forState:UIControlStateNormal];
  _navButton.layer.cornerRadius = 5;
  [_navButton addTarget:self action:@selector(didTapPageControl:) forControlEvents:UIControlEventTouchUpInside];
  
  [self addSubview:_scrollView];
  [self addSubview:_navButton];
  [_scrollView addSubview:_label];
  
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  _scrollView.frame = self.bounds;
  
  //pad text tail for space
  const CGFloat kPadding =  0.5 * CGRectGetWidth(self.bounds);
  CGRect boundingRect = [_label.attributedText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(self.bounds)) options:0 context:0];
  _navButton.hidden = boundingRect.size.width <= self.bounds.size.width;
  boundingRect.size.width += kPadding;
  boundingRect.origin = CGPointZero;
  _label.frame = boundingRect;
  CGRect navButtonFrame = CGRectMake(0, 0, 24, MIN(24, CGRectGetHeight(_label.frame)));
  navButtonFrame.origin.x = CGRectGetWidth(self.bounds) - _navButton.bounds.size.width;
  navButtonFrame.origin.y = 0.5 * (CGRectGetHeight(self.bounds) - navButtonFrame.size.height);
  _navButton.frame = navButtonFrame;
  
  CGSize contentSize = boundingRect.size;
  contentSize.width += kPadding;
  _scrollView.contentSize = contentSize;
}

#pragma mark - scrollview delegate


#pragma mark - properties and methods
- (void)_updateText
{
  _label.attributedText = self.attributedString;
  [_scrollView setContentOffset:CGPointMake(0, 0)];
  [self layoutSubviews];
}

- (CGSize)intrinsicContentSize
{
  return _label.bounds.size;
}


- (void)didTapPageControl:(id)sender
{
  CGFloat pageWidth = CGRectGetWidth(_scrollView.bounds) - (CGRectGetWidth(_navButton.bounds) * 2);
  NSInteger totalPages = (NSInteger)(_scrollView.contentSize.width / CGRectGetWidth(_scrollView.bounds)) + 1;

  _currentPage = (_currentPage + 1) % totalPages;
  [_scrollView setContentOffset:CGPointMake(_currentPage * pageWidth, 0) animated:YES];
}

- (void)setAttributedString:(NSAttributedString *)attributedText
{
  if ([_attributedString isEqual:attributedText]) {
    return;
  }
  
  _attributedString = attributedText;
  [self _updateText];
}

#pragma mark - init
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self _initialize];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self _initialize];
  }
  return self;
}

@end
