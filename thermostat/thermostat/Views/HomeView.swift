//
//  ContentView.swift
//  thermostat
//
//  Created by Jack Wesolowski on 5/19/24.
//

import SwiftUI

struct HomeView: View {
    @State private var currentTemp: Double = 72.0
    @State private var heatSetpoint = 70
    @State private var coolSetpoint = 80
    @State private var count = 0

    var body: some View {
        TabView {
          ControlPanelView()
            .tabItem {
              Image(systemName: "thermometer")
              Text("Thermostat")
            }
            .tag(1)
          Text("Hi")
            .tabItem {
              Image(systemName: "map")
              Text("Map")
            }
            .tag(2)
          SettingsPanelView()
            .tabItem {
              Image(systemName: "gearshape")
              Text("Settings")
            }
            .tag(3)
        }
    }
}

#Preview {
    HomeView()
}
