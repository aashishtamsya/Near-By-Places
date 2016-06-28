//
//  ARSPopover.h
//  Finding Nearer Places
//
//  Created by apple on 01/07/15.
//  Copyright (c) 2015 Pragati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipsideViewController.h"
#import "Place.h"
#import "MarkerView.h"

@interface ARSPopover : UIViewController
/// Use this property to configure where popover's arrow should be pointing.
@property (nonatomic, assign) UIPopoverArrowDirection arrowDirection;

/// The view containing the anchor rectangle for the popover.
@property (nonatomic, weak) UIView *sourceView;

/// The rectangle in the specified view in which to anchor the popover.
@property (nonatomic, assign) CGRect sourceRect;

/// The preferred size for the popover’s view.
@property (nonatomic, assign) CGSize contentSize;

/// The color of the popover’s backdrop view.
@property (nonatomic, strong) UIColor *backgroundColor;

/// An array of views that the user can interact with while the popover is visible.
@property (nonatomic, strong) NSArray *passthroughViews;

///The margins that define the portion of the screen in which it is permissible to display the popover.
@property (nonatomic, assign) UIEdgeInsets popoverLayoutMargins;


@property(nonatomic,retain) UITextView * txtView;


-(instancetype)initWithContent:(Place *)place ;//markerView:(MarkerView *)markerView;


@end
