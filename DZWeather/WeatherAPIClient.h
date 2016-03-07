//
//  WeatherAPIClient.h
//  DZWeather
//
//  Created by David Zheng on 3/7/16.
//  Copyright © 2016 David Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherAPIClient : NSObject

+ (WeatherAPIClient *)sharedClient;

-(void)getWeatherForCityID:(NSUInteger)cityID successBlock:(void (^)(NSDictionary* dict))success failBlock:(void (^)())failure;

@end
