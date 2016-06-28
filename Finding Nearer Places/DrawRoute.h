//
//  DrawRoute.h
//  Finding Nearer Places
//
//  Created by Felix-its 001 on 02/07/15.
//  Copyright (c) 2015 Pragati. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface DrawRoute : NSObject

@property (nonatomic,assign) NSMutableArray *path;
- (NSMutableArray*)parseResponse:(NSDictionary *)response;
-(NSMutableArray *)decodePolyLine:(NSString *)encodedStr;

@end
