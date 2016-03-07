//
//  FormatterVendor.m
//  DZWeather
//
//  Created by David Zheng on 3/7/16.
//  Copyright © 2016 David Zheng. All rights reserved.
//

#import "FormatterVendor.h"

@implementation FormatterVendor

+ (FormatterVendor*)sharedFormatter{
    static FormatterVendor* sharedFormatter = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedFormatter = [[self alloc] init];
    });
    return sharedFormatter;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self generateDateFormatter];
    }
    return self;
}

-(void)generateDateFormatter{
    self.formatter = [[NSDateFormatter alloc] init];
    NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"MMM d" options:0 locale:[NSLocale currentLocale]];
    [self.formatter setDateFormat:formatString];
}

@end
