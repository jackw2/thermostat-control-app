//
//  ContentView.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/3/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var settingsModel = SettingsModelOld.standard
    private var locationManager = CLLocationManager()
    
    var body: some View {
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
        .onAppear() {
            locationManager.requestAlwaysAuthorization()
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @StateObject private var settings = SettingsModel.shared
        
        var body: some View {
            ContentView()
                .environmentObject(settings)
        }
    }
    return PreviewWrapper()
}
