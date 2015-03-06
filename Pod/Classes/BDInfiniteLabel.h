//
//  BDInfiniteLabel.h
//  BDInfiniteLabel
//
//  Created by Norsez Orankijanan on 2/27/15.
//  Copyright (c) 2015 bluedot. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 Main class for BDInfiniteLabel. A text control that displays one-line 
 NSAttributedString with a button for the user to page through the long text, if needed.
 */
@interface BDInfiniteLabel : UIView
/**
 The text to display.
 */
@property (nonatomic, strong) NSAttributedString* attributedString;
/**
 The string used on the paging button to indicate that there is more text to display.
 */
@property (nonatomic, strong) NSString* hasMoreIndicatorText;
/**
 The string used on the paging button to indicate that this is the end of all text.
 */
@property (nonatomic, strong) NSString* goBackIndicatorText;

/**
 Transparency value for the has more button. 
 */
@property (nonatomic, assign) CGFloat hasMoreButtonTransparency;

/**
 Padding size of the has more button.
 */
@property (nonatomic, assign) CGFloat hasMoreButtonPadding;

/**
 Disable the has more button and disguise it as UILabel.
 */
@property (nonatomic, assign) BOOL hasMoreButtonHidden;
@end
