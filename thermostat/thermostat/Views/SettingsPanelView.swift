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

    var body: some View {
        NavigationStack {
            Form {
                Section() {
                    TextField("Server URL", text: $serverURL)
                    SecureField("Authentication Secret", text: $authSecret)
                }
                .navigationTitle("Settings")
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            }
        }
    }
}

#Preview {
    SettingsPanelView()
}
