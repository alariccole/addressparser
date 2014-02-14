//
//  SHPAddressUtils.m
//  ShypAddressParser
//
//  Created by Alaric Cole on 2/14/14.
//  Copyright (c) 2014 Alaric Cole. All rights reserved.
//

#import "SHPAddressUtils.h"

@implementation SHPAddressUtils

+(NSDictionary*)addressComponentsFromAddress:(NSString*)address
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
				// grab string from beginning of string to beginning of this match
				//TODO: strip out organization if necessary
				name = [address substringToIndex:match.range.location - 1];
								//force it in
				if(name) addressDictionary[NSTextCheckingNameKey] = name;

			}


            //NSLog(@"addressComponents  %@",addressDictionary);


			break;
		}





	}

	//cleanup and remove whitespace
	[addressDictionary enumerateKeysAndObjectsUsingBlock:^(id key, NSString* obj, BOOL *stop) {
		addressDictionary[key] = [obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

	}];

	return addressDictionary.copy;
	
}

@end
