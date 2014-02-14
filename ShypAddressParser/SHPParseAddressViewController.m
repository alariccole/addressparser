//
//  SHPViewController.m
//  ShypAddressParser
//
//  Created by Alaric Cole on 2/8/14.
//  Copyright (c) 2014 Alaric Cole. All rights reserved.
//

#import "SHPParseAddressViewController.h"
#import "SHPConfirmAddressViewController.h"
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

-(NSDictionary*)parseAddress:(NSString*)address
{
	NSMutableDictionary * addressDictionary;

	NSError *error = nil;
	NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeAddress  error:&error];

	NSArray *matches = [detector matchesInString:address options:0 range:NSMakeRange(0, [address length])];
	for (NSTextCheckingResult *match in matches)
	{
		//assuming just one address here and returning the first one
		if ([match resultType] == NSTextCheckingTypeAddress)
        {

            addressDictionary = [match addressComponents].mutableCopy;

			NSString *name = addressDictionary[NSTextCheckingNameKey];
			//the name does not seem to get populated
			//if not, grab the first part of the string
			if (!name && match.range.location > 0) {
				// strip whitespace, grab string from beginning of string to beginning of this match
				//TODO: strip out organization if necessary
				name = [address substringToIndex:match.range.location - 1];

				//force it in
				if(name) addressDictionary[NSTextCheckingNameKey] = name;

			}
            NSLog(@"addressComponents  %@",addressDictionary);

			return addressDictionary.copy;

        }



	}

	return addressDictionary;

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

	if ([segue.identifier isEqualToString:@"confirmSegue"]) {


		 NSDictionary *addressComponents = [self parseAddress:self.addressTextView.text	];

		SHPConfirmAddressViewController * confirmAddressController = (SHPConfirmAddressViewController*)segue.destinationViewController;

		confirmAddressController.addressComponents = addressComponents;


	}
		


}
@end
