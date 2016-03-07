//
//  NSDate+DateUtils.h
//  DZWeather
//
//  Created by David Zheng on 3/6/16.
//  Copyright © 2016 David Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DateUtils)

-(BOOL)isToday;
-(BOOL)isNight;

-(NSDate*)dateWithoutTime;

-(NSString *)dayOfWeek;
-(NSString *)abbrevDateString;

@end
