//
//  ContentView.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/3/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
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
