//
//  LocationModel.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/9/24.
//

import Foundation
import CoreLocation
import Combine

class LocationModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let settings: SettingsModel
    private let thermostat: ThermostatModel
    
    let locationManager: CLLocationManager
    private var inRadius: Bool = false {
        didSet {
            thermostat.awayMode = inRadius ? .home : .away
            print("inRadius is now \(inRadius)")
        }
    }
    
    init(settings: SettingsModel, thermostat: ThermostatModel) {
        self.settings = settings
        self.thermostat = thermostat
        
        // location manager delegate
        self.locationManager = CLLocationManager()
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.pausesLocationUpdatesAutomatically = true
    }
    
}
