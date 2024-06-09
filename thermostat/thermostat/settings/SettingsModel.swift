//
//  SettingsModel.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/3/24.
//
import SwiftUI
import Combine

class SettingsModel: ObservableObject {
    static let shared = SettingsModel()
    
    private init() {
        if let storedSecret = getAuthenticationSecret() {
            authSecret = storedSecret
        }
    }
    
    // MARK: Server Settings
    @Published @AppStorage("serverURL") var serverURL: String = ""
    @Published var authSecret: String = "" {
        didSet {
            saveAuthenticationSecret(authSecret)
        }
    }
    private let keychainAccount = "com.thermostat.authenticationSecret"
    private func saveAuthenticationSecret(_ secret: String) {
        KeychainUtility.savePassword(secret, for: keychainAccount)
    }
    
    private func getAuthenticationSecret() -> String? {
        return KeychainUtility.getPassword(for: keychainAccount)
    }

    // MARK: Home settings
    // Home address defaulting to the White House on first launch
    @AppStorage("homeTitle") var homeTitle: String = "The White House"
    @AppStorage("homeLatitude") var homeLatitude: Double = 38.897957
    @AppStorage("homeLongitude") var homeLongitude: Double = 38.897957
    
    // MARK: Misc settings
    @AppStorage("homeRadiusInMiles") var homeRadiusInMiles: Int = 1
    var homeRadiusInMeters: Double {
        // 1 mile = 1609.34 meters
        return Double(homeRadiusInMiles) * 1609.34
    }
}
