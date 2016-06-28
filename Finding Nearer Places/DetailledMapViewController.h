//
//  DetailledMapViewController.h
//  Finding Nearer Places
//
//  Created by Felix-its 001 on 25/06/15.
//  Copyright (c) 2015 Pragati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Annotation.h"
#import "DrawRoute.h"


@interface DetailledMapViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;

   // NSMutableArray *path;
    
    NSDictionary * geo;

}



@property (strong, nonatomic) IBOutlet MKMapView *detailledMapView;
@property (strong, nonatomic) IBOutlet UILabel *lblLocationName;
@property (strong, nonatomic) IBOutlet UILabel *lblLocationAddress;

@property (strong, nonatomic)NSString *locationName;
@property (strong, nonatomic)NSString *locationAddress;

//@property (strong , nonatomic)NSString *destinationName;
//@property (strong , nonatomic)NSString *destinationAddress;


@property (nonatomic, assign)CLLocationCoordinate2D coordinate;
@property(nonatomic,retain)NSDictionary * place;

@end
