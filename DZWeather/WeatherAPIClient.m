//
//  WeatherAPIClient.m
//  DZWeather
//
//  Created by David Zheng on 3/7/16.
//  Copyright © 2016 David Zheng. All rights reserved.
//

#import "WeatherAPIClient.h"

@interface WeatherAPIClient()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation WeatherAPIClient

+ (WeatherAPIClient*)sharedClient{
    static WeatherAPIClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] init];
    });
    return sharedClient;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        self.session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

-(void)getWeatherForCityID:(NSUInteger)cityID successBlock:(void (^)(NSDictionary *))success failBlock:(void (^)())failure{
    NSString *appID = @"15838ff3cd798751427de19cb4a5c00b";
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast?id=%d&mode=json&appid=%@", cityID, appID];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *resp = (NSHTTPURLResponse*)response;
        if (resp.statusCode == 200) {
            NSError *jsonError;
            
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if (success) {
                success(jsonDict);
            }
        }
        else {
            if (failure) {
                failure();
            }
        }
    }];
    
    [dataTask resume];
}

@end
