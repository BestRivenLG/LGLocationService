//
//  ViewController.m
//  位置定位
//
//  Created by mac on 16/5/31.
//  Copyright © 2016年 ZnLG. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *shengshiLabel;
@property (weak, nonatomic) IBOutlet UILabel *jingweiLabel;
@property (nonatomic,strong) CLLocationManager *locationManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建CLLocationManager对象
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLLocationAccuracyBest;
    //设置代理为自己
    self.locationManager.delegate = self;

    

}
- (IBAction)locationAction:(id)sender {
    
    [self.locationManager requestWhenInUseAuthorization];//申请定位服务权限

    [self.locationManager startUpdatingLocation];
    

}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"locations == %@",locations);

    CLLocation *newLocation = [locations objectAtIndex:0];

//    newLocation.
    
    //将经度显示到label上
    self.jingweiLabel.text = [NSString stringWithFormat:@"经度:%lf \n纬度:%lf", newLocation.coordinate.longitude,newLocation.coordinate.latitude];
//    self.shengshiLabel.text = [NSString stringWithFormat:@"经度:%lf \n纬度:%lf", newLocation.countryCode ,newLocation.coordinate.latitude];
    [self.locationManager stopUpdatingLocation];
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *place in placemarks ) {
            NSDictionary *location = [place addressDictionary];
            NSLog(@"%@",location);
            NSLog(@"国家 %@",[location objectForKey:@"Country"]);
            NSLog(@"城市 %@",[location objectForKey:@"State"]);
            NSLog(@"区 %@",[location objectForKey:@"SubLocality"]);
            NSLog(@"位置 %@",place.name);
            NSLog(@"国家 %@",place.country);
            NSLog(@"城市 %@",place.locality);
            NSLog(@"区 %@",place.subLocality);
            NSLog(@"街道 %@",place.thoroughfare);
            NSLog(@"子街道 %@",place.subThoroughfare);
            
            self.shengshiLabel.text = [NSString stringWithFormat:@"位置:%@ ",place.name];

        }
    }];
    
    
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"str == %@",[error description]);

}


@end
