//
//  FlipsideViewController.m
//  Finding Nearer Places
//
//  Created by MacBook Pro on 30/06/15.
//  Copyright (c) 2015 Pragati. All rights reserved.
//

#import "FlipsideViewController.h"

#import "Place.h"
#import "PlacesLoader.h"
#import "MarkerView.h"

#import "ViewController.h"

#import "ARSPopover.h"


NSString * const kPhoneKey = @"formatted_phone_number";
NSString * const kWebsiteKey = @"website";

const int kInfoViewTag = 1001;


@interface FlipsideViewController ()<ARDelegate,ARLocationDelegate,MarkerViewDelegate>

@property (nonatomic, strong) AugmentedRealityController *arController;
@property (nonatomic, strong) NSMutableArray *geoLocations;


@end

@implementation FlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * selectedSegmentIndex = [defaults objectForKey:@"index1"];
    
    _mySegment.selectedSegmentIndex = [selectedSegmentIndex intValue];
    
    if(!_arController)
    {
        _arController = [[AugmentedRealityController alloc] initWithView:[self view] parentViewController:self withDelgate:self];
    }
    
    [_arController setMinimumScaleFactor:0.5];
    [_arController setScaleViewsBasedOnDistance:YES];
    [_arController setRotateViewsBasedOnPerspective:YES];
    [_arController setDebugMode:NO];
    
    // self.mylabel.text =[NSString stringWithFormat:@"%lu",(unsigned long)self.locations.count ];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self generateGeoLocations];
}




#pragma mark - Actions

- (IBAction)done:(id)sender
{
    //[[self delegate] flipsideViewControllerDidFinish:self];
}

- (void)generateGeoLocations
{
    [self setGeoLocations:[NSMutableArray arrayWithCapacity:[_locations count]]];
    
    for(Place *place in _locations)
    {
        ARGeoCoordinate *coordinate = [ARGeoCoordinate coordinateWithLocation:[place location] locationTitle:[place placeName]];
        
        [coordinate calibrateUsingOrigin:[_userLocation location]];
        
        MarkerView *markerView = [[MarkerView alloc] initWithCoordinate:coordinate delegate:self];
        
        NSLog(@"Marker view %@", markerView);
        
        [coordinate setDisplayView:markerView];
        [_arController addCoordinate:coordinate];
        [_geoLocations addObject:coordinate];
    }
}

#pragma mark - ARLocationDelegate

-(NSMutableArray *)geoLocations
{
    if(!_geoLocations)
    {
        [self generateGeoLocations];
    }
    return _geoLocations;
}

- (void)locationClicked:(ARGeoCoordinate *)coordinate
{
    NSLog(@"Tapped location %@", coordinate);
}

#pragma mark - ARDelegate

-(void)didUpdateHeading:(CLHeading *)newHeading
{
    
}

-(void)didUpdateLocation:(CLLocation *)newLocation
{
    
}

-(void)didUpdateOrientation:(UIDeviceOrientation)orientation
{
    
}

#pragma mark - ARMarkerDelegate

-(void)didTapMarker:(ARGeoCoordinate *)coordinate
{
}

- (void)didTouchMarkerView:(MarkerView *)markerView
{
    ARGeoCoordinate *tappedCoordinate = [markerView coordinate];
    CLLocation *location = [tappedCoordinate geoLocation];
    
    int index = [_locations indexOfObjectPassingTest:^(id obj, NSUInteger index, BOOL *stop){
        Place * p = obj;
        return [[p location] isEqual:location];
    }];
    
    if(index != NSNotFound)
    {
        Place *tappedPlace = [_locations objectAtIndex:index];
        
        [[PlacesLoader sharedInstance] loadDetailInformation:tappedPlace successHanlder:^(NSDictionary *response) {
            NSLog(@"Response: %@", response);
            NSDictionary *resultDict = [response objectForKey:@"result"];
            [tappedPlace setPhoneNumber:[resultDict objectForKey:kPhoneKey]];
            [tappedPlace setWebsite:[resultDict objectForKey:kWebsiteKey]];
            [self showInfoViewForPlace:tappedPlace markerView:markerView];
        } errorHandler:^(NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}

- (void)showInfoViewForPlace:(Place *)place markerView:(MarkerView *)markerView
{
//    CGRect frame = [[self view] frame];
//
//    UITextView *infoView = [[UITextView alloc]init];//[[UITextView alloc] initWithFrame:CGRectMake(50.0f, 50.0f, frame.size.width - 100.0f, frame.size.height - 100.0f)];
//    
//    [infoView setCenter:[[self view] center]];
//    
//    [infoView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
//    
//    [infoView setText:[place infoText]];
//    
//    [infoView setTag:kInfoViewTag];
//    
//    [infoView setEditable:NO];

    //[[self view] addSubview:infoView];
    
    ARSPopover *popoverController = [[ARSPopover alloc]initWithContent:place];//WithContent:place];
    
    //[popoverController initWithContent:place ];//markerView:markerView];
    
    popoverController.sourceView =markerView;
    
   // popoverController.contentSize =CGSizeMake(300, 100);
    //popoverController.sourceRect =CGRectMake(CGRectGetMidX(popoverController.txtView.bounds), CGRectGetMaxY(popoverController.txtView.bounds), 0, 0);
    
    //popoverController.sourceRect = CGRectMake(CGRectGetMidX(markerView.bounds), CGRectGetMaxY(markerView.bounds), 0, 0);
    
    [self presentViewController:popoverController animated:YES completion:nil];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *infoView = [[self view] viewWithTag:kInfoViewTag];
    
    [infoView removeFromSuperview];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigationPass the selected object to the new view controller.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // 
}
*/

- (IBAction)btnTapped:(id)sender
{
    ARSPopover *popoverController = [[ARSPopover alloc] init];
    popoverController.sourceView = self.button;
    
     popoverController.sourceRect = CGRectMake(CGRectGetMidX(self.button.bounds), CGRectGetMaxY(self.button.bounds), 0, 0);
   // popoverController.contentSize = CGSizeMake(100, 50);
    
    popoverController.arrowDirection = UIPopoverArrowDirectionUp;
    
    [self presentViewController:popoverController animated:YES completion:nil];
}
@end
