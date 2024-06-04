//
//  ContentView.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/3/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var settingsModel = SettingsModel.standard
    private var locationManager = CLLocationManager()
    
    var body: some View {
        TabView() {
            ControlPanelView()
                .tag("ControlPanel")
                .tabItem {
                    Image(systemName: "thermometer")
                    Text("Thermostat")
                }
            MapOverwatchView()
                .tag("MapOverwatch")
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
            SettingsPanelView()
                .tag("SettingsPanel")
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
        .environment(settingsModel)
        .onAppear() {
            locationManager.requestAlwaysAuthorization()
        }
    }
}

#Preview {
    ContentView()
}
