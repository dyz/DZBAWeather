//
//  NSDate+DateUtils.m
//  DZWeather
//
//  Created by David Zheng on 3/6/16.
//  Copyright © 2016 David Zheng. All rights reserved.
//

#import "NSDate+DateUtils.h"
#import "FormatterVendor.h"

@implementation NSDate (DateUtils)

-(BOOL)isToday{
    return [self sameCalendarDayAsDate:[NSDate date]];
}

-(BOOL)isNight{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags = NSCalendarUnitHour;
    
    NSDateComponents *dateComps = [calendar components:flags fromDate:self];
    //arbitrarily defining night as 6 pm
    return [dateComps hour] > 18;
}

-(BOOL)sameCalendarDayAsDate:(NSDate*)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags = NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitMonth;
    
    NSDateComponents *date1 = [calendar components:flags fromDate:self];
    NSDateComponents *date2 = [calendar components:flags fromDate:date];
    
    return ([date1 day] == [date2 day] && [date1 year] == [date2 year] && [date1 month] == [date2 month]);
}

-(NSDate *)dateWithoutTime{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags = NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *dateComponent = [calendar components:flags fromDate:self];
    dateComponent.hour = 00;
    dateComponent.minute = 00;
    dateComponent.second = 00;
    
    
    return [calendar dateFromComponents:dateComponent];
}

-(NSString *)dayOfWeek{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags = NSCalendarUnitWeekday;
    
    NSDateComponents *dateComponent = [calendar components:flags fromDate:self];
    NSInteger weekDay = [dateComponent weekday];
    NSArray *weekdays = @[@"0", @"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday"];
    return weekdays[weekDay];
}

-(NSString *)abbrevDateString{
    return [[FormatterVendor sharedFormatter].formatter stringFromDate:self];
}

@end
