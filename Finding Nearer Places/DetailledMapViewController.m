//
//  DetailledMapViewController.m
//  Finding Nearer Places
//
//  Created by Felix-its 001 on 25/06/15.
//  Copyright (c) 2015 Pragati. All rights reserved.
//

#import "DetailledMapViewController.h"

@interface DetailledMapViewController ()

@end

@implementation DetailledMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//    userDefaults  = [NSUserDefaults standardUserDefaults];
//    NSString * segmentIndex = [userDefaults objectForKey:@"index"];
//    
//    _mySegment.selectedSegmentIndex =[segmentIndex intValue];
    
    self.lblLocationName.text = self.locationName;
    self.lblLocationAddress.text = self.locationAddress;
    
    self.detailledMapView.delegate =self;
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    [locationManager requestAlwaysAuthorization];
    [locationManager requestWhenInUseAuthorization];
    
    [self.detailledMapView showsUserLocation];
//    Annotation * an  = [[Annotation alloc]init];
//
//    CLLocationCoordinate2D cord = CLLocationCoordinate2DMake(18.5333, 73.8514);
//    
//    an.title = self.locationName;
//    an.subtitle = self.locationAddress;
//    an.coordinate =cord;
//    
//    [_detailledMapView addAnnotation:an];
    
  //  Annotation * an1  = [[Annotation alloc]init];
    
   // CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(18.5302, 73.8567);
    
//    an1.title = self.destinationName;
//    an1.subtitle = self.destinationAddress;
//    an1.coordinate =coord;
//    
//    [_detailledMapView addAnnotation:an1];
    
    [self addAnnotationFromTableView];
    [self addAnnotatationsFromMapView];
    
    //[self drawRouteBetweenPath];
}

-(void)addAnnotationFromTableView
{
//    for (Annotation *ann in self.detailledMapView.annotations)
//    {
//        [self.detailledMapView removeAnnotation:ann];
//    }
    
    geo = [self.place valueForKey:@"geometry"];
    
    NSDictionary *coordinateDic = [geo valueForKey:@"location"];
    
    CLLocationCoordinate2D myCoordinate;
    myCoordinate.latitude = [[coordinateDic valueForKey:@"lat"]doubleValue];
    myCoordinate.longitude = [[coordinateDic valueForKey:@"lng"]doubleValue];
    
    Annotation * an =[[Annotation alloc]init];
    an.coordinate = myCoordinate;
    an.title = [_place valueForKey:@"name"];
    an.subtitle = [_place valueForKey:@"vicinity"];
    
//    self.lblLocationName.text = an.title;
//    self.lblLocationAddress.text = an.subtitle;

    [self.detailledMapView addAnnotation:an];

    
    [self drawRouteBetweenPath:myCoordinate];
}

-(void)addAnnotatationsFromMapView
{
//    for (Annotation *ann in self.detailledMapView.annotations)
//    {
//        [self.detailledMapView removeAnnotation:ann];
//    }
    
    Annotation * an  = [[Annotation alloc]init];
   // CLLocationCoordinate2D cord = CLLocationCoordinate2DMake(self.coordinate.latitude,self.coordinate.longitude);
    
    
    an.title = self.locationName;
    an.subtitle = self.locationAddress;
    an.coordinate =self.coordinate;
    
//    self.lblLocationName.text = self.locationName;
//    self.lblLocationAddress.text = self.locationAddress;
    
    [_detailledMapView addAnnotation:an];
    
    // Annotation * ann  = [[Annotation alloc]init];
    //    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(locationManager.location.coordinate.latitude,locationManager.location.coordinate.longitude);
    
    // ann.title = @"You";
    //    ann.subtitle = self.locationAddress;
    //    ann.coordinate =coord;
    //
    //    [_detailledMapView addAnnotation:ann];
    
    [self drawRouteBetweenPath:self.coordinate];
}


-(void)drawRouteBetweenPath:(CLLocationCoordinate2D)cordinates
{
    DrawRoute * dr =[[DrawRoute alloc]init];
    
    CLLocationCoordinate2D sorceCoord = CLLocationCoordinate2DMake(locationManager.location.coordinate.latitude,locationManager.location.coordinate.longitude);//18.5333, 73.8514);
    
    CLLocationCoordinate2D destCoord = CLLocationCoordinate2DMake(cordinates.latitude,cordinates.longitude);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&key=AIzaSyB7C6preVHRx7PUbj0k0lkPluQdJF0CRww",sorceCoord.latitude,sorceCoord.longitude,destCoord.latitude,destCoord.longitude]];
    
    // Request Google Directions API to retrieve the route:
    NSData *data = [ NSData dataWithContentsOfURL:url];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSMutableArray * paths = [dr parseResponse:dic];
    
    // Create the MKPolyline annotation:
    CLLocationCoordinate2D coordinates[paths.count];
    
    for (NSInteger index = 0; index < paths.count; index++)
    {
        CLLocation *location = [paths objectAtIndex:index];
        CLLocationCoordinate2D coordinate = location.coordinate;
        
        coordinates[index] = coordinate;
    }
    MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:coordinates count:paths.count];
    [self.detailledMapView addOverlay:polyLine];
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    polylineView.strokeColor = [UIColor redColor];
    polylineView.lineWidth = 5.0;
    
    return polylineView;
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MKCoordinateRegion region;
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(locationManager.location.coordinate.latitude,locationManager.location.coordinate.longitude);//18.5333, 73.8514);
    
    //    18.5333° N, 73.8514
    
    region = MKCoordinateRegionMakeWithDistance(coord, 600, 600);
    
    [self.detailledMapView setRegion:region animated:YES];
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
