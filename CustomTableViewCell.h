//
//  CustomTableViewCell.h
//  Finding Nearer Places
//
//  Created by Felix-its 001 on 25/06/15.
//  Copyright (c) 2015 Pragati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblAddress;

@property (strong, nonatomic) IBOutlet UIImageView *imgView;


@end
