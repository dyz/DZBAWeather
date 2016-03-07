//
//  WeatherDayData.m
//  DZWeather
//
//  Created by David Zheng on 3/6/16.
//  Copyright © 2016 David Zheng. All rights reserved.
//

#import "WeatherDayData.h"

@implementation WeatherDayData

-(instancetype)initWithData:(NSArray*)data date:(NSDate*)date{
    self = [super init];
    if (self) {
        [self processData:data];
        self.date = date;
    }
    
    return self;
}

-(void)processData:(NSArray *)data{
    double maxTemp = -INFINITY;
    double minTemp = INFINITY;
    NSMutableArray *weatherStates = [[NSMutableArray alloc] init];
    for (int i = 0; i<data.count; i++) {
        NSDictionary *dataDict = data[i];
        double tempF = [self kelvinToFarenheit:[((NSDictionary *)dataDict[@"main"])[@"temp"] doubleValue]];
        if (tempF > maxTemp) {
            maxTemp = tempF;
        }
        if (tempF < minTemp) {
            minTemp = tempF;
        }
        
        NSDictionary *weatherDict = [dataDict[@"weather"] firstObject];
        [weatherStates addObject:@([self weatherStateForCode:[weatherDict[@"id"] integerValue]])];
    }
    self.maxTemp = maxTemp;
    self.minTemp = minTemp;
    self.state = [self getDailyStateForStateList:weatherStates];
}

-(double)kelvinToFarenheit:(double)kelvin{
    return 1.8 * kelvin - 459.67;
}

//http://openweathermap.org/weather-conditions for codes info
-(WeatherState)weatherStateForCode:(NSUInteger)code{
    if (code == 800) {
        return Clear;
    }
    else {
        NSUInteger family = code / 100;
        switch (family) {
            case 2:
                return Thunderstorm;
                break;
            case 3:
                return Drizzle;
                break;
            case 5:
                return Rain;
                break;
            case 6:
                return Snow;
                break;
            case 7:
                return Atmosphere;
                break;
            case 8:
                return Clouds;
                break;
            case 9:
                return Extreme;
                break;
            default:
                return Clear;
                break;
        }
    }
}

-(WeatherState)getDailyStateForStateList:(NSArray *)list{
    //basic logic:
    //if a day ever has extreme, thunderstorm, snow, rain, drizzle, or atmospheric issue (like fog), show that as the day's status.  If it has multiple of these, pick the most "severe", with severity ranked in said order
    //if a day is only cloudy and clear, pick whatever is more frequent, with ties going to cloudy
    
    WeatherState mostSevere = [[list valueForKeyPath:@"@max.intValue"] integerValue];
    
    if (mostSevere >= Atmosphere) {
        return mostSevere;
    }
    else {
        NSInteger clearCount = 0;
        for (int i = 0; i < list.count; i++) {
            if ([list[i] integerValue] == Clear) {
                clearCount++;
                if (clearCount > list.count/2) {
                    return Clear;
                }
            }
        }
        return Clouds;
    }
    
}


@end
