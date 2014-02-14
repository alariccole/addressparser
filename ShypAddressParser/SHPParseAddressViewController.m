//
//  SHPViewController.m
//  ShypAddressParser
//
//  Created by Alaric Cole on 2/8/14.
//  Copyright (c) 2014 Alaric Cole. All rights reserved.
//

#import "SHPParseAddressViewController.h"
#import "SHPConfirmAddressViewController.h"
#import "SHPAddressUtils.h"

@interface SHPParseAddressViewController ()

@end

@implementation SHPParseAddressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

	if ([segue.identifier isEqualToString:@"confirmSegue"]) {


		 NSDictionary *addressComponents = [SHPAddressUtils addressComponentsFromAddress:self.addressTextView.text];

		SHPConfirmAddressViewController * confirmAddressController = (SHPConfirmAddressViewController*)segue.destinationViewController;

		confirmAddressController.addressComponents = addressComponents;


	}
		


}
@end
