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
  UIButton *_nextButton;
  UIButton *_prevButton;
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
//  _scrollView.scrollEnabled = NO;
  //_scrollView.pagingEnabled = YES;
  _scrollView.bounces = NO;
  _label = [[UILabel alloc] initWithFrame:CGRectZero];
  _label.numberOfLines = 1;
  _label.lineBreakMode = NSLineBreakByClipping;
  _nextButton = [[UIButton alloc] initWithFrame:CGRectZero];
//  _nextButton.backgroundColor = [UIColor clearColor];
  [_nextButton setTitle:@"▷" forState:UIControlStateNormal];
  [_nextButton addTarget:self action:@selector(didPressNext:) forControlEvents:UIControlEventTouchUpInside];
  _prevButton = [[UIButton alloc] initWithFrame:CGRectZero];
//  _prevButton.backgroundColor = [UIColor clearColor];
  [_prevButton setTitle:@"◁" forState:UIControlStateNormal];
  [_prevButton addTarget:self action:@selector(didPressPrev:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:_scrollView];
  [self addSubview:_nextButton];
  [self addSubview:_prevButton];
  [_scrollView addSubview:_label];
  
  NSArray* constraints = @[];
  NSDictionary* views = NSDictionaryOfVariableBindings(_scrollView, _prevButton, _nextButton);
  constraints = [constraints arrayByAddingObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"|-(0)-[_scrollView]-(0)-|" options:0 metrics:nil views:views]];
  constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_prevButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.15 constant:1]];
  constraints = [constraints arrayByAddingObject:[NSLayoutConstraint constraintWithItem:_nextButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.15 constant:1]];
  constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(0)-[_prevButton]-(>=8)-[_nextButton]-(0)-|" options:0 metrics:nil views:views]];
  constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[_prevButton]-(0)-|" options:0 metrics:nil views:views]];
  constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[_nextButton]-(0)-|" options:0 metrics:nil views:views]];
  constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[_scrollView]-(0)-|" options:0 metrics:nil views:views]];
                 
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  _scrollView.frame = self.bounds;
  
  CGRect boundingRect = [_label.attributedText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(self.bounds)) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:0];
  _label.frame = boundingRect;
  _scrollView.contentSize = boundingRect.size;
  
}
#pragma mark - scrollview delegate


#pragma mark - properties and methods
- (void)_updateText
{
  _label.attributedText = self.attributedString;
  [self setNeedsLayout];
}

- (CGSize)intrinsicContentSize
{
  return _label.bounds.size;
}


- (void)didPressNext:(id)sender
{
  
}

- (void)didPressPrev:(id)sender
{
  
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
