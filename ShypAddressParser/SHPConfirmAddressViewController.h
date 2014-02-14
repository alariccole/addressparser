//
//  SHPConfirmAddressViewController.h
//  ShypAddressParser
//
//  Created by Alaric Cole on 2/8/14.
//  Copyright (c) 2014 Alaric Cole. All rights reserved.
//

@import UIKit;

@interface SHPConfirmAddressViewController : UITableViewController
extern NSString *const kAddressCell;


@property (strong, nonatomic) NSDictionary *addressComponents;

@property (strong, nonatomic) NSArray *addressComponentsArray;


@end
