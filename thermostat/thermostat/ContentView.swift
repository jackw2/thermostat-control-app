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
            if location.locationAlwaysPermissionGranted {
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
                VStack {
                    Text("The app requires your location to enable and disable your thermostat.")
                        .padding()
                    Button(action: {
                        location.requestLocationAuthorization()
                    }) {
                        Text("Request Permission")
                    }
                }
                .padding()
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
