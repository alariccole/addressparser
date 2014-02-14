addressparser
=============

Example of using NSDataDetector for parsing an address


Parses out individual parts of an address into separate text fields, when supplied with a block of text.

Paste or edit address in the text field, press Parse Address, and be amazed.


The gist:

NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeAddress  error:&error];

NSArray *matches = [detector matchesInString:address options:0 range:NSMakeRange(0, address.length)];
	
NSTextCheckingResult *match = matches.firstObject;

NSDictionary * addressDictionary = match.addressComponents;

NSString *city = addressDictionary[NSTextCheckingCityKey];
			


Caveats: 
 *	   Only tested for US addresses. Assuming support for international addresses is not as robust
 *     Names don't appear to be parsed, contrary to documentation. Here it is done manually.
 *     There's no built-in support for parsing Apartment/unit numbers apart from the street address.
