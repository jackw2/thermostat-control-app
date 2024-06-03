//
//  SettingsPanel.swift
//  thermostat
//
//  Created by Jack Wesolowski on 5/19/24.
//

import SwiftUI

struct SettingsPanelView: View {
    @AppStorage("serverURL") private var serverURL: String = ""
    @AppStorage("authSecret") private var authSecret: String = ""
    @AppStorage("homeTitle") private var homeTitle: String = "The White House"
    @AppStorage("homeLatitude") private var homeLatitude: Double = 38.897957
    @AppStorage("homeLongitude") private var homeLongitude: Double = -77.036560
    
    @State private var showMap: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Server Connection") {
                    TextField("Server URL", text: $serverURL)
                    SecureField("Authentication Secret", text: $authSecret)
                }
                
                Section("Home Address") {
                    TextField("Home Title", text: $homeTitle)
                    Text("Latitude: \(String(format: "%.6f", homeLatitude))")
                    Text("Longitude: \(String(format: "%.6f", homeLongitude))")
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
    SettingsPanelView()
}
