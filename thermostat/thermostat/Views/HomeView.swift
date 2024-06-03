//
//  ContentView.swift
//  thermostat
//
//  Created by Jack Wesolowski on 5/19/24.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    @State private var currentTemp: Double = 72.0
    @State private var heatSetpoint = 70
    @State private var coolSetpoint = 80
    @State private var count = 0
    private var locationManager = CLLocationManager()
    
    var body: some View {
        TabView {
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
          SettingsPanelView()
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
    HomeView()
}
