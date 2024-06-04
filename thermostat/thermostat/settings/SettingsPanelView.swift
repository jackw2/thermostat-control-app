//
//  SettingsPanel.swift
//  thermostat
//
//  Created by Jack Wesolowski on 5/19/24.
//

import SwiftUI

struct SettingsPanelView: View {
    @Environment(SettingsModel.self) private var settingsModel
    @State var a = 1
    var body: some View {
        NavigationStack () {
            Form {
                Section("Server Connection") {
                    TextField("Server URL", text: Binding<String>(
                        get: {settingsModel.serverURL},
                        set: {settingsModel.serverURL = $0}))
                    SecureField("Authentication Secret", text: Binding<String>(
                        get: {settingsModel.authSecret},
                        set: {settingsModel.authSecret = $0}))
                }
                
                Section("Home Address") {
                    TextField("Home Title", text: Binding<String>(
                        get: {settingsModel.homeTitle},
                        set: {settingsModel.homeTitle = $0}))
                    
                    Text("Latitude: \(String(format: "%.6f", settingsModel.homeLatitude))")
                    Text("Longitude: \(String(format: "%.6f", settingsModel.homeLongitude))")
                    NavigationLink("Set Home Address", value: "address")
                        .navigationDestination(for: String.self) { _ in
                            AddressSearchView()
                        }
                }
            }
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var settingsModel = SettingsModel.standard
        
        var body: some View {
            SettingsPanelView()
                .environment(settingsModel)
        }
    }
    return PreviewWrapper()
}
