//
//  ViewController.swift
//  SwiftExample
//
//  Created by Lukasz Hlebowicz on 14/11/14.
//  Copyright (c) 2014 kontakt.io. All rights reserved.
//


import UIKit
import "KontaktSDK.h"

class ViewController: UIViewController, KTKLocationManagerDelegate, KTKBluetoothManagerDelegate {

    let locationManager : KTKLocationManager = KTKLocationManager();
    let bluetoothManager : KTKBluetoothManager = KTKBluetoothManager();
    
    @IBOutlet weak var labelCounterBeacons: UILabel!
    @IBOutlet weak var labelCounterEddystones: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (KTKLocationManager.canMonitorBeacons())
        {
            let region : KTKRegion = KTKRegion()
            region.uuid = "f7826da6-4fa2-4e98-8024-bc5b71e0893e" // kontakt.io proximity UUID
            
            self.locationManager.setRegions([region])
            self.locationManager.delegate = self
        }
        
        self.bluetoothManager.delegate = self
    }

    override func viewDidAppear(animated: Bool) {
        self.locationManager.startMonitoringBeacons()
        self.bluetoothManager.startFindingDevices()
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.locationManager.stopMonitoringBeacons()
        self.bluetoothManager.stopFindingDevices()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// MARK: - KTKLocationManagerDelegate
    
    func locationManager(locationManager: KTKLocationManager!, didChangeState state: KTKLocationManagerState, withError error: NSError!) {
        if (state == .Failed)
        {
            print("Something went wrong with your Location Services settings. Check your settings.");
        }
    }
    
    func locationManager(locationManager: KTKLocationManager!, didEnterRegion region: KTKRegion!) {
        print("Enter region \(region.identifier)")
    }
    
    func locationManager(locationManager: KTKLocationManager!, didExitRegion region: KTKRegion!) {
        print("Exit region \(region.identifier)")
    }
    
    func locationManager(locationManager: KTKLocationManager!, didRangeBeacons beacons: [AnyObject]!) {
        print("There are \(beacons.count) iBeacons monitored")
    }
    
// MARK: - KTKBluetoothManagerDelegate
    
    func bluetoothManager(bluetoothManager: KTKBluetoothManager!, didChangeDevices devices: Set<NSObject>!) {
        print("There are \(devices.count) Kontakt iBeacons in range")
        
        self.labelCounterBeacons.text = "\(devices.count)"
    }
    
    func bluetoothManager(bluetoothManager: KTKBluetoothManager!, didChangeEddystones eddystones: Set<NSObject>!) {
        print("There are \(eddystones.count) Eddystones in range")
        
        self.labelCounterEddystones.text = "\(eddystones.count)"
    }
}

