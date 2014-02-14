//
//  SHPAddressComponent.h
//  ShypAddressParser
//
//  Created by Alaric Cole on 2/14/14.
//  Copyright (c) 2014 Alaric Cole. All rights reserved.
//

@import Foundation;

@interface SHPAddressComponent : NSObject

-(id)initWithCaption:(NSString*)caption andContent:(NSString*)content;


@property(nonatomic,copy)  NSString * caption;
@property(nonatomic,copy)  NSString * content;
@end
