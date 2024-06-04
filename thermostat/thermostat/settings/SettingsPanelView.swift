//
//  SettingsPanel.swift
//  thermostat
//
//  Created by Jack Wesolowski on 5/19/24.
//

import SwiftUI

struct SettingsPanelView: View {
    @Environment(Model.self) private var model
    
    var body: some View {
        NavigationStack () {
            Form {
                Section("Server Connection") {
                    TextField("Server URL", text: Binding<String>(
                        get: {model.settings.serverURL},
                        set: {model.settings.serverURL = $0}))
                    SecureField("Authentication Secret", text: Binding<String>(
                        get: {model.settings.authSecret},
                        set: {model.settings.authSecret = $0}))
                }
                
                Section("Home Address") {
                    TextField("Home Title", text: Binding<String>(
                        get: {model.settings.homeTitle},
                        set: {model.settings.homeTitle = $0}))
                    
                    Text("Latitude: \(String(format: "%.6f", model.settings.homeLatitude))")
                    Text("Latitude: \(String(format: "%.6f", model.settings.homeLongitude))")
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
        @State private var model = Model()
        
        var body: some View {
            SettingsPanelView()
                .environment(model)
        }
    }
    return PreviewWrapper()
}
