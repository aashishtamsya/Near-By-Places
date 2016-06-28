//
//  TableViewController.h
//  Finding Nearer Places
//
//  Created by Felix ITs 007 on 24/06/15.
//  Copyright (c) 2015 Pragati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ViewController.h"
#import "DetailedTableList.h"
@interface TableViewController : UITableViewController<CLLocationManagerDelegate>
{
    NSMutableArray *array;
    CLLocationManager *locationManager;
    
    NSMutableArray *images;
}
- (UIImage *) makeThumbnailOfSize:(CGSize)size;

//@property(nonatomic, retain)CLLocationManager *loc

@end
