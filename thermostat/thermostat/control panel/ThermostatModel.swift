//
//  ThermostatModel.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/8/24.
//

import Combine
import SwiftUI

enum AwaySetting: String {
    case home = "home"
    case away = "away"
}

enum ModeSetting: String, CaseIterable, CustomStringConvertible, Identifiable {
    case off = "off"
    case heat = "heat"
    case cool = "cool"
    case auto = "auto"
    
    var id: Self { self }
    var description: String {
        self.rawValue.capitalized
    }
}

enum FanSetting: String, CaseIterable, CustomStringConvertible, Identifiable {
    case auto = "auto"
    case on = "on"
    
    var id: Self { self }
    var description: String {
        self.rawValue.capitalized
    }
}

enum CurrentState: Int {
    case idle = 0
    case heating = 1
    case cooling = 2
    case lockout = 3
    case error = 4
}

enum FanState: Int {
    case off = 0
    case on = 1
}

class ThermostatModel: ObservableObject {
    // controls
    @AppStorage("heatTo") var heatTo: Int = 70
    @AppStorage("coolTo") var coolTo: Int = 80
    @AppStorage("mode") var mode: ModeSetting = .auto
    @AppStorage("fanMode") var fanMode: FanSetting = .auto
    
    func toggleFan() {
        fanMode = (fanMode == .auto) ? .on : .auto
    }
    
    // thermostat status
    @Published var spaceTemp: Double = 0.0
    @Published var thermostatState: CurrentState = .idle
    @Published var fanState: FanState = .off
    var statusText: String {
        if fanState == .on && thermostatState == .idle {
            return "Fans Running"
        }
        
        switch thermostatState {
        case .heating:
            return "Heating"
        case .cooling:
            return "Cooling"
        case .lockout:
            return "Lockout"
        case .error:
            return "Error"
        default:
            return "Idle"
        }
    }
    
    // network
    @Published var isConnected = false
    
    // location
    @Published var awayMode: AwaySetting = .away
}
