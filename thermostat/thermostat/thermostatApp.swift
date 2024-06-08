//
//  thermostatApp.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/3/24.
//

import SwiftUI

@main
struct thermostatApp: App {
    @StateObject private var settings = SettingsModel.shared
    @State private var settingsModel = SettingsModelOld.standard
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
                .environment(settingsModel)
        }
    }
}
