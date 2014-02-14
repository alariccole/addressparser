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

NSString *const kAddressCell    = @"AddressCell";



#pragma mark lifecycle
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

#pragma mark MAIN
/*
 * Here we set the individual parts of the address via one dictionary, 
 * then populate our datasource with the parts we're interested in.
 */
-(void)setAddressComponents:(NSDictionary *)addressComponents
{
	_addressComponents = addressComponents;


	//Sorting manually because we expect the order Name, Street, City, Zip, Country.
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

#pragma mark UITableViewDelegate
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

	SHPCell * cell  = [tableView dequeueReusableCellWithIdentifier:kAddressCell];


	NSInteger row = indexPath.row;

	SHPAddressComponent * component =self.addressComponentsArray[row];


	cell.addressComponent = component;



	return cell;
}



@end
