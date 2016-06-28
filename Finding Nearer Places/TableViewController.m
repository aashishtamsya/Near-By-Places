//
//  TableViewController.m
//  Finding Nearer Places
//
//  Created by Felix ITs 007 on 24/06/15.
//  Copyright (c) 2015 Pragati. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    [locationManager requestAlwaysAuthorization];
    [locationManager requestWhenInUseAuthorization];
   
//    array = [[NSMutableArray alloc]initWithObjects:@"Banks",@"Hospitals",@"Coffee shops",@"MultiFlex",@"Police Station",@"Bus Station",@"Schools",@"Hotels",@"Train Station",@"Parkings",@"beauty salon", nil];
//    images = [[NSMutableArray alloc]initWithObjects:@"bank.jpg",@"Hospital.png",@"Coffee shop.png",@"MultiFlex.png",@"Police Station.png",@"Bus Station.png",@"Schools.png",@"Hotels.png",@"Train Station.png",@"Parkings.png",@"beauty salon.png", nil];

    DetailedTableList *d1 = [[DetailedTableList alloc] init];
    
    d1.name=@"Bank";
    d1.imageName=@"bank.png";
    
    DetailedTableList *d2 = [[DetailedTableList alloc] init];
    
    d2.name=@"Hospitals";
    d2.imageName=@"Hospital.png";
    DetailedTableList *d3 = [[DetailedTableList alloc] init];
    
    d3.name=@"Coffee Shops";
    d3.imageName=@"coffee shop.png";

    DetailedTableList *d4 = [[DetailedTableList alloc] init];
    
    d4.name=@"Multi Flex";
    d4.imageName=@"MultiFlex.png";
    
    DetailedTableList *d5 = [[DetailedTableList alloc] init];
    
    d5.name=@"Police Station";
    d5.imageName=@"Bus Station.png";

    
    DetailedTableList *d6 = [[DetailedTableList alloc] init];
    
    d6.name=@"Scools";
    d6.imageName=@"schools.png";

    DetailedTableList *d7 = [[DetailedTableList alloc] init];
    
    d7.name=@"Hotel";
    d7.imageName=@"hotel.png";

    DetailedTableList *d8 = [[DetailedTableList alloc] init];
    
    d8.name=@"Train Station";
    d8.imageName=@"Train Station.png";

    DetailedTableList *d9 = [[DetailedTableList alloc] init];
    
    d9.name=@"Parkings";
    d9.imageName=@"Parkings.png";

    
    DetailedTableList *d10 = [[DetailedTableList alloc] init];
    
    d10.name=@"Beauty Salon";
    d10.imageName=@"Beauty Salon.png";

    
    
    array = [NSMutableArray arrayWithObjects:d1,d2,d3,d4,d5,d6,d7,d8,d9,d10, nil];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *cellIdentifier = @"cell";
    
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
//    CustomTableViewCell * cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
    
    DetailedTableList *dt = [array objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = dt.name;
//    cell.imgView.image = [UIImage imageNamed:dt.imageName];
//    cell.imgView.image = [UIImage imageNamed:[images objectAtIndex:indexPath.row]];

//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
//    
//    UITextView *textLable1 =[[UITextView alloc]initWithFrame:CGRectMake(70, 200, 280, 80)];
//    
//    [textLable1 setText:[array objectAtIndex:indexPath.row]];
//    [textLable1 setFrame:CGRectMake(40, 200, 280, 80)];
//
////    [cell.textLabel addSubview:textLable1];
//    [cell.textLabel setText:textLable1.text];
//
//
////    cell.textLabel.frame = CGRectMake(50, 200, 280, 80);
////    cell.textLabel.text = [array objectAtIndex:indexPath.row];
//    
//
//    
//    UIImageView *imageView = [[UIImageView alloc] init];
//    
//    [imageView setImage:[UIImage imageNamed:[images objectAtIndex:indexPath.row]]];
//    
//    [imageView setBackgroundColor:[UIColor blackColor]];
//    
//    [imageView setContentMode:UIViewContentModeScaleAspectFit];
//    
//    [imageView sizeToFit ];
//    
//    [imageView setFrame:CGRectMake(20, 20, 50, 50)];
//    
//    
//    [cell.contentView addSubview:imageView];
    
    
//    cell.imageView.image = [UIImage imageNamed:[images objectAtIndex:indexPath.row]];

    
    // Configure the cell...
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewController *vc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
 
    [self.navigationController pushViewController:vc1 animated:YES];
    vc1.index = indexPath.row;
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    self.imageView.frame = CGRectMake(0,0,32,32);
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
