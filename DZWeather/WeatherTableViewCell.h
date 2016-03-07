//
//  WeatherTableViewCell.h
//  DZWeather
//
//  Created by David Zheng on 3/7/16.
//  Copyright © 2016 David Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherDayData.h"

@interface WeatherTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *highLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowLabel;

@property (weak, nonatomic) IBOutlet UILabel *weatherIcon;

-(void)updateWithData:(WeatherDayData*)data;

@end
