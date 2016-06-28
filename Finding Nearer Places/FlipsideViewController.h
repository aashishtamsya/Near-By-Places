//
//  FlipsideViewController.h
//  Finding Nearer Places
//
//  Created by MacBook Pro on 30/06/15.
//  Copyright (c) 2015 Pragati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ARKit.h"
#import <CoreLocation/CoreLocation.h>

@interface FlipsideViewController : UIViewController<UIPopoverPresentationControllerDelegate>

@property (nonatomic, strong) NSArray *locations;
@property (nonatomic, strong) MKUserLocation *userLocation;

@property(nonatomic,retain)CLLocationManager * locationManager;


//@property (strong, nonatomic) IBOutlet UILabel *mylabel;


@property (strong, nonatomic) IBOutlet UISegmentedControl *mySegment;


- (IBAction)btnTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end
