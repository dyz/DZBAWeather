//
//  WeatherDayData.h
//  DZWeather
//
//  Created by David Zheng on 3/6/16.
//  Copyright © 2016 David Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

//in order of "severity"
typedef NS_ENUM(NSInteger, WeatherState) {
    Clear,
    Clouds,
    Atmosphere,
    Drizzle,
    Rain,
    Snow,
    Thunderstorm,
    Extreme
};

@interface WeatherDayData : NSObject

@property (nonatomic) double minTemp;
@property (nonatomic) double maxTemp;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic) WeatherState state;

-(instancetype)initWithData:(NSArray*)data date:(NSDate*)date;

@end
