//
//  SHPConfirmAddressViewController.h
//  ShypAddressParser
//
//  Created by Alaric Cole on 2/8/14.
//  Copyright (c) 2014 Alaric Cole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHPConfirmAddressViewController : UITableViewController

@property (strong, nonatomic) NSDictionary *addressComponents;



@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *organizationTextField;
@property (strong, nonatomic) IBOutlet UITextField *streetTextField;
@property (strong, nonatomic) IBOutlet UITextField *cityTextField;
@property (strong, nonatomic) IBOutlet UITextField *stateTextField;
@property (strong, nonatomic) IBOutlet UITextField *zipTextField;
@property (strong, nonatomic) IBOutlet UITextField *countryTextField;


@end
