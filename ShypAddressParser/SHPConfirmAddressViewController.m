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

@property (strong, nonatomic) NSArray *addressComponentsArray;

@property (strong, nonatomic) IBOutlet UIImageView *mapImageView;

@property (nonatomic, strong) MKMapSnapshotter *mapSnapshotter;

@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, copy) NSString *normalizedAddressString;

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

-(void)setNormalizedAddressString:(NSString *)normalizedAddressString
{
	if (_normalizedAddressString && [_normalizedAddressString isEqualToString:normalizedAddressString]) {
		return;
	}

	CLGeocoder * geocoder = [[CLGeocoder alloc] init];
	[geocoder geocodeAddressString:normalizedAddressString completionHandler:^(NSArray *placemarks, NSError *error) {

		CLPlacemark* firstPlacemark = placemarks.firstObject;
		if (firstPlacemark) {
			self.location = firstPlacemark.location;
		}

	}];
}

-(void)parseAddressComponentsIntoNormalizedAddress
{

	NSString * street = _addressComponents[NSTextCheckingStreetKey];
	NSString * city = _addressComponents[NSTextCheckingCityKey];
	NSString * zip = _addressComponents[NSTextCheckingZIPKey];
	NSString * country = _addressComponents[NSTextCheckingCountryKey];


	NSMutableString * addressString = [[NSMutableString alloc] init];
	if (street) {

		[addressString appendString:street];
	}
	if (city) {

		[addressString appendFormat:@", %@", city];
	}
	if (zip) {

		[addressString appendFormat:@", %@", zip];
	}
	if (country) {

		[addressString appendFormat:@", %@", country];
	}

	self.normalizedAddressString = addressString.copy;

}
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

	NSString * name = _addressComponents[NSTextCheckingNameKey];
	NSString * street = _addressComponents[NSTextCheckingStreetKey];
	NSString * city = _addressComponents[NSTextCheckingCityKey];
	NSString * zip = _addressComponents[NSTextCheckingZIPKey];
	NSString * country = _addressComponents[NSTextCheckingCountryKey];

	self.addressComponentsArray = @[
									[[SHPAddressComponent alloc] initWithCaption:NSLocalizedString(@"Name", nil) andContent:name],
									[[SHPAddressComponent alloc] initWithCaption:NSLocalizedString(@"Street", nil) andContent:street],
									[[SHPAddressComponent alloc] initWithCaption:NSLocalizedString(@"City", nil) andContent:city],
									[[SHPAddressComponent alloc] initWithCaption:NSLocalizedString(@"Zip", nil) andContent:zip],
									[[SHPAddressComponent alloc] initWithCaption:NSLocalizedString(@"Country", nil) andContent:country]
									];


	[self parseAddressComponentsIntoNormalizedAddress];



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

-(MKMapSnapshotter*)mapSnapshotterWithLocation:(CLLocation*)location
{

	MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
	options.size = self.mapImageView.frame.size; //self.bounds.size;//
	options.scale = [[UIScreen mainScreen] scale]; // iOS only

	MKMapCamera * camera = [MKMapCamera camera];

	camera.pitch = 50;
	CLLocationDistance altitude = 300;//overview

	camera.altitude =altitude;
	camera.centerCoordinate = self.location.coordinate;

	options.camera =camera;

	options.showsPointsOfInterest = YES;
	options.showsBuildings = YES;

	//necessary for 3d
	options.mapType = MKMapTypeStandard;

	_mapSnapshotter = [[MKMapSnapshotter alloc] initWithOptions:options];


	return _mapSnapshotter;
}



-(void)setLocation:(CLLocation *)location
{
	if (_location && location == _location ) {
		return;
	}


	if (location ) {

		_location	= location;


		if (self.mapSnapshotter.isLoading ) {
			[self.mapSnapshotter cancel];
		}


		self.mapSnapshotter = [self mapSnapshotterWithLocation:_location];

		//since some graphics manipulation has been added, go ahead and run generation on a bg queue
		[self.mapSnapshotter  startWithQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
						   completionHandler:^(MKMapSnapshot *snapshot, NSError *error)
		 {


			 if (error) {

				 NSLog(@"%@",[error localizedDescription]);
				 return;
			 }


			UIImage *image = snapshot.image;


			//TODO: check MKPolyline
			MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:nil];
			pin.pinColor = MKPinAnnotationColorGreen;


			UIGraphicsBeginImageContextWithOptions(image.size, YES, image.scale);

			[image drawAtPoint:CGPointMake(0.0f, 0.0f)];

			CGRect rect = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);

			 CGPoint point = [snapshot pointForCoordinate:location.coordinate];
			 if (CGRectContainsPoint(rect, point)) {
				 point.x = point.x + pin.centerOffset.x -
				 (pin.bounds.size.width / 2.0f);
				 point.y = point.y + pin.centerOffset.y -
				 (pin.bounds.size.height / 2.0f);
				 [pin.image drawAtPoint:point];
			 }



			 UIImage *compositeImage = UIGraphicsGetImageFromCurrentImageContext();

			 UIGraphicsEndImageContext();

			 //run UI methods on the main thread
			 dispatch_async(dispatch_get_main_queue(),
			   ^{

				   self.mapImageView.image = compositeImage;

				   //fade into view once we have an image
				   [UIView animateWithDuration:2.0 delay:0. options:UIViewAnimationOptionCurveEaseInOut animations:^{

					   self.mapImageView.alpha = 1.0;

				   } completion:nil];

			   });


		 }];
		
	}

	
}



@end
