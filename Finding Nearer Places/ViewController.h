//
//  ViewController.h
//  Finding Nearer Places
//
//  Created by Felix ITs 007 on 24/06/15.
//  Copyright (c) 2015 Pragati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Annotation.h"
#import <CoreLocation/CoreLocation.h>
#import "DetailledMapViewController.h"
#import "Annotation.h"
#import "CustomTableViewCell.h"
#import "FlipsideViewController.h"



@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager1;
    NSMutableArray *placesTypes;
    
    NSMutableArray * result;
    
    NSDictionary *place;
    NSDictionary *geo;

    CLLocationCoordinate2D myCoordinate;
    NSDictionary *coordinateDic;
    
    NSString *type;
    NSUserDefaults * userDefaults;
}
@property (nonatomic)NSInteger index;

@property(nonatomic,retain)NSString *selectedSegmentIndex;


@property (strong, nonatomic) IBOutlet UITableView *MyTableView;
@property (strong, nonatomic) IBOutlet MKMapView *myMapView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *mySegment;


@property (nonatomic, strong) NSArray *locations;


- (IBAction)SegmentTapped:(id)sender;

@end

