//
//  SHPConfirmAddressViewController.m
//  ShypAddressParser
//
//  Created by Alaric Cole on 2/8/14.
//  Copyright (c) 2014 Alaric Cole. All rights reserved.
//

#import "SHPConfirmAddressViewController.h"
#import "SHPCell.h"
#import "SHPAddressComponent.h"

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


//
//	self.nameTextField.text = self.addressComponents[NSTextCheckingNameKey];
//	//self.organizationTextField.text = self.addressComponents[NSTextCheckingOrganizationKey];
//
//
//	self.streetTextField.text = self.addressComponents[NSTextCheckingStreetKey];
//	self.cityTextField.text = self.addressComponents[NSTextCheckingCityKey];
//	self.stateTextField.text = self.addressComponents[NSTextCheckingStateKey];
//	self.zipTextField.text = self.addressComponents[NSTextCheckingZIPKey];
//	self.countryTextField.text = self.addressComponents[NSTextCheckingCountryKey];
//

//	self.addressComponentsArray = @[
//									self.addressComponents[NSTextCheckingNameKey],
//									self.addressComponents[NSTextCheckingStreetKey],
//									self.addressComponents[NSTextCheckingCityKey],
//									self.addressComponents[NSTextCheckingZIPKey],
//									self.addressComponents[NSTextCheckingCountryKey],
//
//									];
}

-(void)setAddressComponents:(NSDictionary *)addressComponents
{
	_addressComponents = addressComponents;


	//sorting manually because we expect the order Name, Street, City, Zip, Country.
	//This order could change due to locale
	//TODO: check ABCreateStringWithAddressDictionary() or other method to arrange an address according to locale



	self.addressComponentsArray = @[
									[[SHPAddressComponent alloc] initWithCaption:NSLocalizedString(@"Name", nil) andContent:_addressComponents[NSTextCheckingNameKey]],
									[[SHPAddressComponent alloc] initWithCaption:NSLocalizedString(@"Street", nil) andContent:_addressComponents[NSTextCheckingStreetKey]],
									[[SHPAddressComponent alloc] initWithCaption:NSLocalizedString(@"City", nil) andContent:_addressComponents[NSTextCheckingCityKey]],
									[[SHPAddressComponent alloc] initWithCaption:NSLocalizedString(@"Zip", nil) andContent:_addressComponents[NSTextCheckingZIPKey]],
									[[SHPAddressComponent alloc] initWithCaption:NSLocalizedString(@"Country", nil) andContent:_addressComponents[NSTextCheckingCountryKey]]
									];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.addressComponentsArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

	SHPCell * cell  = [tableView dequeueReusableCellWithIdentifier:@"CELL"];


	NSInteger row = indexPath.row;

	SHPAddressComponent * component =self.addressComponentsArray[row];


	cell.addressComponent = component;



	return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
