//
//  ViewController.m
//  Finding Nearer Places
//
//  Created by Felix ITs 007 on 24/06/15.
//  Copyright (c) 2015 Pragati. All rights reserved.
//

#import "ViewController.h"
#import "PlacesLoader.h"
#import "Place.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    userDefaults  = [NSUserDefaults standardUserDefaults];
    NSString * segmentIndex = [userDefaults objectForKey:@"index"];
    
    _mySegment.selectedSegmentIndex =[segmentIndex intValue];
    
    self.myMapView.delegate = self;
    locationManager1 = [[CLLocationManager alloc]init];
    locationManager1.delegate = self;
    
    [locationManager1 requestWhenInUseAuthorization];
    [locationManager1 requestAlwaysAuthorization];
    [locationManager1 setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [locationManager1 startUpdatingLocation];
    [self.myMapView showsUserLocation];

    
    
    placesTypes = [[NSMutableArray alloc]initWithObjects:@"bank",@"hospital",@"cafe",@"movie_theater",@"police",@"bus_station",@"school",@"food",@"train_station",@"parking",@"beauty_salon", nil];
    type= [placesTypes objectAtIndex:self.index];
    
    
    NSLog(@"%f",locationManager1.location.coordinate.latitude);
    NSLog(@"%f",locationManager1.location.coordinate.longitude);
    
    
    
    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=500&types=%@&sensor=true&key=AIzaSyB7C6preVHRx7PUbj0k0lkPluQdJF0CRww",locationManager1.location.coordinate.latitude,locationManager1.location.coordinate.longitude,type]];//18.5333, 73.8514,type]];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=500&types=%@&sensor=true&key=AIzaSyB7C6preVHRx7PUbj0k0lkPluQdJF0CRww",18.5333, 73.8514,type]];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    
    [self performSelectorOnMainThread:@selector(getAllPlaces:) withObject:data waitUntilDone:YES];
    
//    [self getAllPlaces:data];
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)getAllPlaces:(NSData *)data
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    result = [dic valueForKey:@"results"];
    
    NSLog(@"Places = %@",result);
    
    for (Annotation *ann in self.myMapView.annotations)
    {
        [self.myMapView removeAnnotation:ann];
    }
    for (int i=0; i<result.count; i++)
    {
        Annotation *an = [[Annotation alloc]init];
        place = [result objectAtIndex:i];
        geo = [place valueForKey:@"geometry"];
        
        coordinateDic = [geo valueForKey:@"location"];
        
//        CLLocationCoordinate2D myCoordinate;
        
        myCoordinate.latitude = [[coordinateDic valueForKey:@"lat"]doubleValue];
        myCoordinate.longitude = [[coordinateDic valueForKey:@"lng"]doubleValue];
        
        an.coordinate = myCoordinate;
        an.title = [place valueForKey:@"name"];
        an.subtitle = [place valueForKey:@"vicinity"];
        
        [self.myMapView addAnnotation:an];
        
    }
    
    [self.MyTableView reloadData];
}


#pragma mark - CLLocationManager Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *lastLocation = [locations lastObject];
    
    CLLocationAccuracy accuracy = [lastLocation horizontalAccuracy];
    
    NSLog(@"Received location %@ with accuracy %f", lastLocation, accuracy);
    
  //  if(accuracy < 100.0)
   // {
        //  MKCoordinateSpan span = MKCoordinateSpanMake(0.14, 0.14);
        // MKCoordinateRegion region = MKCoordinateRegionMake([lastLocation coordinate], span);
        
        // [_myMapView setRegion:region animated:YES];
        _myMapView.showsUserLocation=YES;
        
        [[PlacesLoader sharedInstance] loadPOIsForLocation:[locations lastObject] radius:1000 successHanlder:^(NSDictionary *response)
         {
             NSLog(@"Response: %@", response);
             if([[response objectForKey:@"status"] isEqualToString:@"OK"])
             {
                 id places = [response objectForKey:@"results"];
                 NSMutableArray *temp = [NSMutableArray array];
                 
                 if([places isKindOfClass:[NSArray class]])
                 {
                     for(NSDictionary *resultsDict in places)
                     {
                         CLLocation *location = [[CLLocation alloc] initWithLatitude:[[resultsDict valueForKeyPath:@"geometry.location.lat"] floatValue] longitude:[[resultsDict valueForKeyPath:@"geometry.location.lng"] floatValue]];
                         
                         Place *currentPlace = [[Place alloc] initWithLocation:location reference:[resultsDict objectForKey:@"reference"] name:[resultsDict objectForKey:@"name"] address:[resultsDict objectForKey:@"vicinity"]];
                         
                         [temp addObject:currentPlace];
                         
                         // PlaceAnnotation *annotation = [[PlaceAnnotation alloc] initWithPlace:currentPlace];
                         //                         [_myMapView addAnnotation:annotation];
                     }
                 }
                 
                 _locations = [temp copy];
                 
              //NSLog(@"Locations: %@", _locations);
             }
         }
         errorHandler:^(NSError *error) {
             NSLog(@"Error: %@", error);
         }];
        
        [manager stopUpdatingLocation];
    //}
}


#pragma mark - mapview delegate and methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    DetailledMapViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailledMapViewController"];
    
    Annotation * ann = view.annotation;
    
    // [self presentViewController:VC animated:YES completion:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
    VC.locationName = ann.title;
    VC.locationAddress = ann.subtitle;
    VC.coordinate =ann.coordinate;
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MKCoordinateRegion region;
    
//    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(locationManager1.location.coordinate.latitude,locationManager1.location.coordinate.longitude);//18.5333, 73.8514);
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(18.5333, 73.8514);
    
//    18.5333° N, 73.8514
    
    region = MKCoordinateRegionMakeWithDistance(coord, 1000, 1000);
    
    [self.myMapView setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView Data source and methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return result.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellSegment" forIndexPath:indexPath];
    
    tableView.estimatedRowHeight = 44.0;
    tableView.rowHeight = UITableViewAutomaticDimension;
    
    [cell.lblAddress setLineBreakMode:NSLineBreakByWordWrapping];
    [cell.lblName setLineBreakMode:NSLineBreakByWordWrapping];
    
    
    place = [result objectAtIndex:indexPath.row];
    
    cell.lblName.text = [place valueForKey:@"name"];
    cell.lblAddress.text = [place valueForKey:@"vicinity"];
    
    NSString *imageUrlString = [place valueForKey:@"icon"];
    
    NSString *encodedImageUrlString = [imageUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *imageURL = [NSURL URLWithString: encodedImageUrlString];
    
    NSData * data = [NSData dataWithContentsOfURL:imageURL];
    cell.imgView.image = [UIImage imageWithData:data];
    
    cell.imgView.layer.cornerRadius = cell.imgView.bounds.size.width/2;
    cell.imgView.layer.masksToBounds = YES;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailledMapViewController *dmvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailledMapViewController"];
    
    [self.navigationController pushViewController:dmvc animated:YES];
    self.index = indexPath.row;
    
    place = [result objectAtIndex:indexPath.row];
    
    dmvc.locationName = [place valueForKey:@"name"];
    dmvc.locationAddress = [place valueForKey:@"vicinity"];
//    dmvc.coordinate = an.coordinate;
    
    dmvc.place =place;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * title = [NSString stringWithFormat:@"List of %@s",type];
    return title;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

#pragma mark - segment Methods
- (IBAction)SegmentTapped:(id)sender
{
    UISegmentedControl  * segment = sender;
    
    if (segment.selectedSegmentIndex == 0)
    {
        [self.MyTableView setHidden:NO];
        [self.myMapView setHidden:YES];
        self.selectedSegmentIndex = @"0";
        [userDefaults setObject:self.selectedSegmentIndex forKey:@"index"];
        [userDefaults synchronize];
    }
    else if (segment.selectedSegmentIndex == 1)
    {
        [self.MyTableView setHidden:YES];
        [self.myMapView setHidden:NO];
        self.selectedSegmentIndex = @"1";
        [userDefaults setObject:self.selectedSegmentIndex forKey:@"index"];
        [userDefaults synchronize];
    }
    else if (segment.selectedSegmentIndex == 2)
    {
        FlipsideViewController * VC = [self.storyboard instantiateViewControllerWithIdentifier:@"FlipsideViewController"];
        
        [self.navigationController pushViewController:VC animated:YES];
        
        VC.userLocation = _myMapView.userLocation;
        VC.locations = _locations;
        
        self.selectedSegmentIndex = @"2";
        
        [userDefaults setObject:self.selectedSegmentIndex forKey:@"index1"];
        [userDefaults synchronize];
        
    }
    
    
}
@end
