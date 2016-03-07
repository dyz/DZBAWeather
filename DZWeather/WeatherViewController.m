//
//  WeatherViewController.m
//  DZWeather
//
//  Created by David Zheng on 3/6/16.
//  Copyright © 2016 David Zheng. All rights reserved.
//

#import "WeatherViewController.h"
#import "NSDate+DateUtils.h"
#import "WeatherDayData.h"
#import "WeatherTableViewCell.h"
#import "WeatherAPIClient.h"

@interface WeatherViewController ()

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchRemoteWeatherData];
}

//used this for testing
- (void)loadJSONFromFile{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"json"];
    
    NSError *error = nil;
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    
    id JSONObject = [NSJSONSerialization
                     JSONObjectWithData:JSONData
                     options:NSJSONReadingAllowFragments
                     error:&error];
    
    self.data = (NSDictionary *)JSONObject;
}

- (void)fetchRemoteWeatherData{
    NSUInteger nyID = 5128581;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[WeatherAPIClient sharedClient] getWeatherForCityID:nyID successBlock:^(NSDictionary *dict) {
            self.data = dict;
            [self generateDataSource];
            [self getTitle];
        } failBlock:^{
            NSLog(@"Something went wrong");
        }];
    });
}

- (void)getTitle{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *cityData = self.data[@"city"];
        self.titleLabel.text = cityData[@"name"];
    });
}

- (void)generateDataSource{
    NSArray *list = self.data[@"list"];
    NSDictionary *dataSplitByDates = [self splitListByDates:list];
    NSArray *dates = [[dataSplitByDates allKeys] sortedArrayUsingSelector:@selector(compare:)];
    self.dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i<5; i++) {
        NSDate *date = dates[i];
        WeatherDayData *data = [[WeatherDayData alloc] initWithData:dataSplitByDates[date] date:date];
        [self.dataSource addObject:data];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (NSDictionary *)splitListByDates:(NSArray *)list{
    NSMutableDictionary *lists = [[NSMutableDictionary alloc] init];
    for (NSDictionary *data in list) {
        NSDate *date = [[NSDate dateWithTimeIntervalSince1970:[data[@"dt"] doubleValue]] dateWithoutTime];
        if (!lists[date]){
            lists[date] = [[NSMutableArray alloc] init];
        }
        NSMutableArray *dataForDate = lists[date];
        [dataForDate addObject:data];
    }
    return lists;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weatherCell"];
    
    [cell updateWithData:self.dataSource[indexPath.row]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.f;
}


@end
