//
//  WeatherTableViewCell.m
//  DZWeather
//
//  Created by David Zheng on 3/7/16.
//  Copyright © 2016 David Zheng. All rights reserved.
//

#import "WeatherTableViewCell.h"
#import "NSDate+DateUtils.h"

@implementation WeatherTableViewCell

-(void)updateWithData:(WeatherDayData*)data{
    self.highLabel.text = [NSString stringWithFormat:@"%.0f",data.maxTemp];
    self.lowLabel.text = [NSString stringWithFormat:@"%.0f",data.minTemp];
    
    BOOL isToday = [data.date isToday];
    
    self.dayLabel.text = (isToday)?@"Today" : [data.date dayOfWeek];
    self.dateLabel.text = [data.date abbrevDateString];
    
    switch (data.state) {
        case Clear:
            self.backgroundColor = [UIColor whiteColor];
            
            //if its today and currently night, use the clear night icon
            if (isToday && [[NSDate date] isNight]) {
                self.weatherIcon.text = @"\uf02e";
                self.weatherIcon.textColor = [UIColor whiteColor];
                self.highLabel.textColor = [UIColor whiteColor];
                self.dayLabel.textColor = [UIColor whiteColor];
                self.dateLabel.textColor = [UIColor whiteColor];
                self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.8];
            }
            //otherwise, use the clear day icon
            else {
                self.weatherIcon.text = @"\uf00d"; //sunny
                self.weatherIcon.textColor = [UIColor yellowColor];
                self.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:.6];
            }
        
            break;
        case Clouds:
            self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.7];
            self.lowLabel.textColor = [UIColor whiteColor];
            self.weatherIcon.text = @"\uf013";
            break;
        case Atmosphere:
            //assume this means fog for simplicity
            self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.7];
            self.lowLabel.textColor = [UIColor whiteColor];
            self.weatherIcon.text = @"\uf014";
            break;
        case Drizzle:
            self.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:.7];
            self.weatherIcon.text = @"\uf01a";
            break;
        case Rain:
            self.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:.7];
            self.weatherIcon.text = @"\uf019";
            break;
        case Snow:
            self.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:.3];
            self.weatherIcon.text = @"\uf01b";
            self.weatherIcon.textColor = [UIColor whiteColor];
            break;
        case Thunderstorm:
            self.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:.7];
            self.weatherIcon.text = @"\uf01e";
            break;
        case Extreme:
            self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.7];
            self.lowLabel.textColor = [UIColor whiteColor];
            self.weatherIcon.text = @"\uf0ce";
            break;
        default:
            break;
    }
}

@end
