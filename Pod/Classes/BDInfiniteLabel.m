//
//  BDInfiniteLabel.m
//  BDInfiniteLabel
//
//  Created by Norsez Orankijanan on 2/27/15.
//  Copyright (c) 2015 bluedot. All rights reserved.
//

#import "BDInfiniteLabel.h"
#define kWidthNavButton 24
@interface NoTouchScrollView : UIScrollView

@end

@implementation NoTouchScrollView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
  return nil;
}

@end


@interface BDInfiniteLabel () <UIScrollViewDelegate>
{
  UIScrollView* _scrollView;
  UILabel *_label;
  UIButton *_hasMoreButton;
  NSInteger _currentPage;
}


@end

@implementation BDInfiniteLabel

- (void)_initialize
{
  _hasMoreIndicatorText = @"…";
  _goBackIndicatorText = @"⬅︎";
  _hasMoreButtonTransparency = 0.35;
  
  self.backgroundColor = [UIColor clearColor];
  _scrollView = [[NoTouchScrollView alloc] initWithFrame:CGRectZero];
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
  
  _hasMoreButton = [[UIButton alloc] initWithFrame:CGRectZero];
  _hasMoreButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  _hasMoreButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.45];
  _hasMoreButton.alpha = self.hasMoreButtonTransparency;
  [_hasMoreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [_hasMoreButton setAttributedTitle:[[NSAttributedString alloc] initWithString:self.hasMoreIndicatorText attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14], NSForegroundColorAttributeName: [UIColor whiteColor]}]  forState:UIControlStateNormal];
  _hasMoreButton.layer.cornerRadius = 5;
  [_hasMoreButton addTarget:self action:@selector(didTapPageControl:) forControlEvents:UIControlEventTouchUpInside];
  
  [self addSubview:_scrollView];
  [self addSubview:_hasMoreButton];
  [_scrollView addSubview:_label];
  
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  _scrollView.frame = self.bounds;
  
  //pad text tail for space
  CGRect boundingRect = [_label.attributedText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(self.bounds)) options:0 context:0];
  _hasMoreButton.hidden = boundingRect.size.width <= self.bounds.size.width;
  
  boundingRect.origin = CGPointZero;
  _label.frame = boundingRect;
  CGRect navButtonFrame = CGRectMake(0, 0, kWidthNavButton, MIN(kWidthNavButton, CGRectGetHeight(_label.frame)));
  navButtonFrame.origin.x = CGRectGetWidth(self.bounds) - _hasMoreButton.bounds.size.width;
  navButtonFrame.origin.y = 0.5 * (CGRectGetHeight(self.bounds) - navButtonFrame.size.height);
  _hasMoreButton.frame = navButtonFrame;
  
  CGSize contentSize = boundingRect.size;
  contentSize.width += 200;
  _scrollView.contentSize = contentSize;
  
  _hasMoreButton.alpha = self.hasMoreButtonTransparency;
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
  CGFloat pageWidth = CGRectGetWidth(_scrollView.bounds) - (CGRectGetWidth(_hasMoreButton.bounds) * 2);
  NSInteger totalPages = (NSInteger)(_scrollView.contentSize.width / CGRectGetWidth(_scrollView.bounds)) + 1;

  _currentPage = (_currentPage + 1) % totalPages;
  CGFloat x = _currentPage * pageWidth;
  [_scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
  
  if (_currentPage == totalPages - 1) {
    
    [UIView animateWithDuration:0.2 animations:^{
      _hasMoreButton.alpha = 0;
    } completion:^(BOOL finished) {
        [_hasMoreButton setAttributedTitle:[[NSAttributedString alloc] initWithString:self.goBackIndicatorText attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14], NSForegroundColorAttributeName: [UIColor whiteColor]}]  forState:UIControlStateNormal];
       [UIView animateWithDuration:0.2 animations:^{
         _hasMoreButton.alpha = 1;
         
       }];
    }];
    
  }else {
    [_hasMoreButton setAttributedTitle:[[NSAttributedString alloc] initWithString:self.hasMoreIndicatorText attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14], NSForegroundColorAttributeName: [UIColor whiteColor]}]  forState:UIControlStateNormal];
  }
  _hasMoreButton.alpha = self.hasMoreButtonTransparency;
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
