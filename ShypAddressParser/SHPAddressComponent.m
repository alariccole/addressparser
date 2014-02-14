//
//  SHPAddressComponent.m
//  ShypAddressParser
//
//  Created by Alaric Cole on 2/14/14.
//  Copyright (c) 2014 Alaric Cole. All rights reserved.
//

#import "SHPAddressComponent.h"

@implementation SHPAddressComponent

-(id)initWithCaption:(NSString*)caption andContent:(NSString*)content
{
	self = [super init];
    if (self) {
        self.caption  = caption;
		self.content  = content;
    }
    return self;

}
@end
