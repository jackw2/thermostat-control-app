//
//  thermostatApp.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/3/24.
//

import SwiftUI

@main
struct thermostatApp: App {
    @StateObject private var settings: SettingsModel
    @StateObject private var thermostat: ThermostatModel
    @StateObject private var location: LocationModel
    
    init() {
        let settings = SettingsModel.shared
        let thermostat = ThermostatModel(settings: settings)
        let location = LocationModel(settings: settings, thermostat: thermostat)
            
        _settings = StateObject(wrappedValue: settings)
        _thermostat = StateObject(wrappedValue: thermostat)
        _location = StateObject(wrappedValue: location)
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
                .environmentObject(thermostat)
                .environmentObject(location)
                .onAppear {
                    location.startMonitoring()
                }
        }
    }
}
