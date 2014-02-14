//
//  SHPAddressUtils.h
//  ShypAddressParser
//
//  Created by Alaric Cole on 2/14/14.
//  Copyright (c) 2014 Alaric Cole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHPAddressUtils : NSObject
+(NSDictionary*)addressComponentsFromAddress:(NSString*)address;
@end
