//
//  SHPCell.m
//  ShypAddressParser
//
//  Created by Alaric Cole on 2/14/14.
//  Copyright (c) 2014 Alaric Cole. All rights reserved.
//

#import "SHPCell.h"

@implementation SHPCell

-(void)setAddressComponent:(SHPAddressComponent *)addressComponent
{
	_addressComponent = addressComponent;
	self.captionLabel.text = _addressComponent.caption;
	self.contentsTextField.text = _addressComponent.content;
}

@end
