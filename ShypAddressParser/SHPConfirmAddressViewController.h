//
//  SHPConfirmAddressViewController.h
//  ShypAddressParser
//
//  Created by Alaric Cole on 2/8/14.
//  Copyright (c) 2014 Alaric Cole. All rights reserved.
//

@import UIKit;
@import MapKit;
@import QuartzCore;

@interface SHPConfirmAddressViewController : UITableViewController
extern NSString *const kAddressCell;


@property (strong, nonatomic) NSDictionary *addressComponents;

@property (strong, nonatomic) NSArray *addressComponentsArray;

@property (strong, nonatomic) IBOutlet UIImageView *mapImageView;

@property (nonatomic, strong) MKMapSnapshotter *mapSnapshotter;

@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, copy) NSString *normalizedAddressString;

@end
