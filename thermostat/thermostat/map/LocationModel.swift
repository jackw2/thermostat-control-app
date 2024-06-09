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
    @Published var inRadius: Bool = false {
        didSet {
            thermostat.awayMode = inRadius ? .home : .away
        }
    }
    
    init(settings: SettingsModel, thermostat: ThermostatModel) {
        self.settings = settings
        self.thermostat = thermostat
        
        // location manager delegate
        self.locationManager = CLLocationManager()
        super.init()
        
        self.locationManager.delegate = self
        requestLocationAuthorization()
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.pausesLocationUpdatesAutomatically = true
        
        
    }
    
    @Published var locationAlwaysPermissionGranted = false
    func requestLocationAuthorization() {
        if locationManager.authorizationStatus != .authorizedAlways {
            // apple requires requesting when in use before always permission
            locationManager.requestWhenInUseAuthorization()
            
            if locationManager.authorizationStatus != .authorizedAlways {
                print("Requesting always authorization")
                locationManager.requestAlwaysAuthorization()
            }
        }
        
        locationAlwaysPermissionGranted = locationManager.authorizationStatus == .authorizedAlways
    }
    
    // MARK: Monitoring
    func startMonitoring() {
        let homeCoordinate = CLLocationCoordinate2D(latitude: settings.homeLatitude, longitude: settings.homeLongitude)
        let homeRadius = settings.homeRadiusInMeters
        
        let region = CLCircularRegion(center: homeCoordinate, radius: homeRadius, identifier: "HomeRegion")
        region.notifyOnEntry = true
        region.notifyOnExit = true
        
        self.locationManager.startMonitoring(for: region)
        self.locationManager.startUpdatingLocation()
    }
    
    func stopMonitoring() {
        let monitoredRegions = locationManager.monitoredRegions
        for region in monitoredRegions {
            if let circularRegion = region as? CLCircularRegion {
                locationManager.stopMonitoring(for: circularRegion)
            }
        }
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: Delegate methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationAlwaysPermissionGranted = manager.authorizationStatus == .authorizedAlways
    }
    
    // CLLocationManagerDelegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        
        let homeCoordinate = CLLocationCoordinate2D(latitude: settings.homeLatitude, longitude: settings.homeLongitude)
        let homeRadius = settings.homeRadiusInMeters
        
        let region = CLCircularRegion(center: homeCoordinate, radius: homeRadius, identifier: "HomeRegion")
        self.inRadius = region.contains(currentLocation.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region.identifier == "HomeRegion" {
            self.inRadius = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region.identifier == "HomeRegion" {
            self.inRadius = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Monitoring failed for region: \(String(describing: region?.identifier)) with error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
}
