//
//  ViewController.m
//  beacontest
//
//  Created by talpais on 04/12/2015.
//  Copyright © 2015 talpais. All rights reserved.
//

#import "ViewController.h"

#import "KontaktSDK.h"

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController () <KTKLocationManagerDelegate, KTKBluetoothManagerDelegate, KTKActionManagerDelegate>

@property KTKLocationManager *locationManager;
@property KTKActionManager *actionManager;

@property UIButton* btn1;
@property UIButton* btn2;

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        
        
        _actionManager = [KTKActionManager new];
        _actionManager.delegate = self;
        
        _locationManager = [KTKLocationManager new];
        _locationManager.delegate = self;
        
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    if ([KTKLocationManager canMonitorBeacons]) {
        KTKRegion *region =[[KTKRegion alloc] init];
        region.uuid = @"f7826da6-4fa2-4e98-8024-bc5b71e0893e"; // kontakt.io proximity UUID
        region.major = @13514;
        region.minor = @47245;
        
        [self.locationManager setRegions:@[region]];
        [self.locationManager startMonitoringBeacons];
        
        KTKBluetoothManager *beaconManager;
        beaconManager = [KTKBluetoothManager new];
        beaconManager.delegate = self;
        [beaconManager startFindingDevices];
    }
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    _btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, screenWidth, 100)];
    [_btn1 setTitle:@"beacon test" forState:UIControlStateNormal];
    [_btn1 setBackgroundColor:[UIColor redColor]];
    
    _btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 300, screenWidth, 100)];
    [_btn2 setTitle:@"beacon test 2" forState:UIControlStateNormal];
    [_btn2 setBackgroundColor:[UIColor blueColor]];
    
    [self.view addSubview:_btn1];
    [self.view addSubview:_btn2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bluetoothManager:(KTKBluetoothManager *)bluetoothManager didChangeDevices:(NSSet *)devices {
    
//    NSLog(@"scanning bluetooth");
    
    NSString* newStr = @"";
    
    NSEnumerator *enumerator = [devices objectEnumerator];
    id obj;
    while (obj =[ enumerator nextObject]) {
//        NSLog(@"%@",obj);
        KTKBeaconDevice* device1 = (KTKBeaconDevice*)obj;
        newStr = [newStr stringByAppendingString:[NSString stringWithFormat:@"%@ %@ %f %f, ", device1.uniqueID, device1.RSSI, [self calculateAccuracy:7 rssi:[device1.RSSI doubleValue]], [self getRange:7 rssi:[device1.RSSI doubleValue]]]];
    }
    NSLog(@"scanning bluetooth - %@",newStr);
    [_btn1 setTitle:newStr forState:UIControlStateNormal];
}

- (void)locationManager:(KTKLocationManager *)locationManager didChangeState:(KTKLocationManagerState)state withError:(NSError *)error
{
    if (state == KTKLocationManagerStateFailed)
    {
        NSLog(@"Something went wrong with your Location Services settings. Check OS settings.");
    }
}

- (void)locationManager:(KTKLocationManager *)locationManager didEnterRegion:(KTKRegion *)region
{
    NSLog(@"Enter region %@", region.uuid);
}

- (void)locationManager:(KTKLocationManager *)locationManager didExitRegion:(KTKRegion *)region
{
    NSLog(@"Exit region %@", region.uuid);
}

- (void)locationManager:(KTKLocationManager *)locationManager didRangeBeacons:(NSArray *)beacons
{
    NSLog(@"Ranged beacons count: %lu", [beacons count]);
    
    NSString* newStr = @"";
    NSMutableDictionary *beaconsData = [NSMutableDictionary new];
    for (CLBeacon *beacon in beacons) {
//        KTKBeacon *beaconData = [self _getDataForBeacon:beacon];
//        if (beaconData) beaconsData[beacon] = beaconData;
        
        newStr = [newStr stringByAppendingString:[NSString stringWithFormat:@"%d %f %d, ",
                                                  (int)beacon.proximity,
                                                  beacon.accuracy,
                                                  beacon.rssi]];
    }
    
    [_btn2 setTitle:newStr forState:UIControlStateNormal];
    
    [_actionManager processBeacons:beacons withData:beaconsData];
}

- (double)calculateAccuracy:(int)txPower  rssi:(double)rssi {
    if (rssi == 0) {
        return -1.0; // if we cannot determine accuracy, return -1.
    }
    
    double ratio = rssi*1.0/txPower;
    if (ratio < 1.0) {
        return pow(ratio,10);
    }
//    else {
//        double accuracy =  (0.89976)*Math.pow(ratio,7.7095) + 0.111;
//        return accuracy;
//    }
    
    return 0;
}

- (double)getRange:(int)txCalibratedPower rssi:(int)rssi {
    double ratio_db = txCalibratedPower - rssi;
    double ratio_linear = pow(10, ratio_db / 10);
    
    double r = sqrt(ratio_linear);
    return r;
}

@end
