//
//  FormatterVendor.h
//  DZWeather
//
//  Created by David Zheng on 3/7/16.
//  Copyright © 2016 David Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormatterVendor : NSObject

@property (nonatomic, strong) NSDateFormatter *formatter;

+(FormatterVendor *)sharedFormatter;

@end
