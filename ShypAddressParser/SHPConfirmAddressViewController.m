//
//  SHPConfirmAddressViewController.m
//  ShypAddressParser
//
//  Created by Alaric Cole on 2/8/14.
//  Copyright (c) 2014 Alaric Cole. All rights reserved.
//

#import "SHPConfirmAddressViewController.h"

@interface SHPConfirmAddressViewController ()

@end

@implementation SHPConfirmAddressViewController


-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];


}
- (void)viewDidLoad
{
    [super viewDidLoad];


	// eg:
	// addressComponents  {
	//     City = Anytown;
	//     Country = USA;
	//     State = NY;
	//     Street = "100 Main Street";
	//     ZIP = 12345;
	// }



	self.nameTextField.text = self.addressComponents[NSTextCheckingNameKey];
	//self.organizationTextField.text = self.addressComponents[NSTextCheckingOrganizationKey];


	self.streetTextField.text = self.addressComponents[NSTextCheckingStreetKey];
	self.cityTextField.text = self.addressComponents[NSTextCheckingCityKey];
	self.stateTextField.text = self.addressComponents[NSTextCheckingStateKey];
	self.zipTextField.text = self.addressComponents[NSTextCheckingZIPKey];
	self.countryTextField.text = self.addressComponents[NSTextCheckingCountryKey];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
