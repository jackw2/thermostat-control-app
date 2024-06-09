//
//  ContentView.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/3/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @EnvironmentObject var location: LocationModel
    
    var body: some View {
        return VStack {
            if location.locationPermissionWasApproved {
                TabView() {
                    ControlPanelView()
                        .tabItem {
                            Image(systemName: "thermometer")
                            Text("Thermostat")
                        }
                    MapOverwatchView()
                        .tabItem {
                            Image(systemName: "map")
                            Text("Map")
                        }
                    SettingsView()
                        .tabItem {
                            Image(systemName: "gearshape")
                            Text("Settings")
                        }
                }
            }
            else {
                Button(action: {
                    location.requestLocationAuthorization()
                }) {
                    Text("Location permission is required to use this app. Go to settings or tap to request permission.")
                }
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
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
        
        var body: some View {
            ContentView()
                .environmentObject(settings)
                .environmentObject(thermostat)
                .environmentObject(location)
        }
    }
    return PreviewWrapper()
}
