//
//  ViewController.m
//  beacontest
//
//  Created by talpais on 04/12/2015.
//  Copyright © 2015 talpais. All rights reserved.
//

#import "ViewController.h"

#import "KontaktSDK.h"

@interface ViewController () <KTKLocationManagerDelegate, KTKBluetoothManagerDelegate>

@property KTKLocationManager *locationManager;
@property UIButton* btn1;

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self)
    {
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
        region.major = @6707;
        region.minor = @16016;
        
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
    
    [self.view addSubview:_btn1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bluetoothManager:(KTKBluetoothManager *)bluetoothManager didChangeDevices:(NSSet *)devices {
    
    NSString* newStr = @"";
    
    NSEnumerator *enumerator = [devices objectEnumerator];
    id obj;
    while (obj =[ enumerator nextObject]) {
        NSLog(@"%@",obj);
        KTKBeaconDevice* device1 = (KTKBeaconDevice*)obj;
        newStr = [newStr stringByAppendingString:[NSString stringWithFormat:@"%@ %@, ", device1.uniqueID, device1.RSSI]];
    }
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
}

@end
