//
//  WeatherViewController.h
//  DZWeather
//
//  Created by David Zheng on 3/6/16.
//  Copyright © 2016 David Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
