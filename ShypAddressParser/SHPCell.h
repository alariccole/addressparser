//
//  SHPCell.h
//  ShypAddressParser
//
//  Created by Alaric Cole on 2/14/14.
//  Copyright (c) 2014 Alaric Cole. All rights reserved.
//

@import UIKit;
#import "SHPAddressComponent.h"

@interface SHPCell : UITableViewCell

@property(nonatomic,strong)  SHPAddressComponent * addressComponent;

@property(nonatomic,strong) IBOutlet UILabel * captionLabel;
@property(nonatomic,strong) IBOutlet UITextField * contentsTextField;
@end
