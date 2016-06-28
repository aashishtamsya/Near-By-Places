//
//  ARSPopover.m
//  Finding Nearer Places
//
//  Created by apple on 01/07/15.
//  Copyright (c) 2015 Pragati. All rights reserved.
//

#import "ARSPopover.h"


@interface ARSPopover ()<UIPopoverPresentationControllerDelegate>

@end 

@implementation ARSPopover


#pragma mark Initialization

- (instancetype)init
{
    if (self = [super init])
    {
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.popoverPresentationController.delegate = self;
        
        
    }
    return self;
}

-(instancetype)initWithContent:(Place *)place //markerView:(MarkerView *)markerView
{
    if (self = [super init])
    {
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.popoverPresentationController.delegate = self;
        
    }
    _txtView = [[UITextView alloc]initWithFrame:CGRectMake(0,0,500,500)];
//   UITextView * txtView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMidX(markerView.bounds), CGRectGetMaxY(markerView.bounds), 100, 100)];
    
        [_txtView setText:[place infoText]];
        [_txtView sizeToFit];
        [_txtView setEditable:NO];
    
     
    [_txtView setCenter:CGPointMake(50, 25)];
    [self.view addSubview:_txtView];

    
    return self;
}
- (void)viewDidLoad
{
    //     You can add content to popover here.
    
    
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button setTitle:@"Close" forState:UIControlStateNormal];
//    [button sizeToFit];
//    [button setCenter:CGPointMake(50, 25)];
//    [button addTarget:self action:@selector(closePopover) forControlEvents:UIControlEventTouchUpInside];
    
    //[self.view addSubview:button];
    
//    UITextView * txtView = [[UITextView alloc]init];
//    [txtView setText:@"jdbkjdsnv jdnscjk jsndckj jncdjks jmlk  jnckjnc n cn jsdnfd "];
//    [txtView sizeToFit];
//    [txtView setCenter:CGPointMake(50, 25)];
//    [self.view addSubview:txtView];
    
}

#pragma mark - Actions

- (void)closePopover
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Popover Presentation Controller Delegate

- (void)prepareForPopoverPresentation:(UIPopoverPresentationController *)popoverPresentationController
{
    self.popoverPresentationController.sourceView = self.sourceView ? self.sourceView : self.view;
    self.popoverPresentationController.sourceRect = self.sourceRect;
    self.preferredContentSize = self.contentSize;
    
    popoverPresentationController.permittedArrowDirections = self.arrowDirection ? self.arrowDirection : UIPopoverArrowDirectionDown;
    
    popoverPresentationController.passthroughViews = self.passthroughViews;
    
    popoverPresentationController.backgroundColor = self.backgroundColor;
    
    popoverPresentationController.popoverLayoutMargins = self.popoverLayoutMargins;
}

#pragma mark - Adaptive Presentation Controller Delegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
