//
//  SettingsView.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/8/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsModel

    var body: some View {
        NavigationStack () {
            Form {
                Section("Server Connection") {
                    TextField("Server URL", text: $settings.serverURL)
                    SecureField("Authentication Secret", text: $settings.authSecret)
                }
                
                Section("Home Address") {
                    TextField("Home Name", text: $settings.homeTitle)
                    Text("Latitude: \(String(format: "%.6f", settings.homeLatitude))")
                    Text("Longitude: \(String(format: "%.6f", settings.homeLongitude))")
                    NavigationLink("Set Home Address", value: "address")
                }
                
                Section("Misc") {
                    Stepper(value: $settings.homeRadiusInMiles, in: 1...10) {
                        Text("Home Radius: \(settings.homeRadiusInMiles) miles")
                    }
                }
            }
            .navigationDestination(for: String.self) { _ in
                AddressSearchView()
            }
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
            .navigationTitle("Settings")
        }
    }
}


#Preview {
    struct PreviewWrapper: View {
        @StateObject private var settings = SettingsModel.shared
        
        var body: some View {
            SettingsView()
                .environmentObject(settings)
        }
    }
    return PreviewWrapper()
}

