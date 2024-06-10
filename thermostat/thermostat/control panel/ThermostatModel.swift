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
        self.rawValue
    }
}

enum FanSetting: String, CaseIterable, CustomStringConvertible, Identifiable {
    case auto = "auto"
    case on = "on"
    
    var id: Self { self }
    var description: String {
        self.rawValue
    }
}

enum CurrentState: Int, Codable {
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
    private let settings: SettingsModel
    
    init(settings: SettingsModel) {
        self.settings = settings
        _ = networkService // force network service to initialize
    }
    
    // controls
    @AppStorage("heatTo") var heatTo: Int = 70 {
        didSet {
            if heatTo > coolTo - 2 {
                coolTo = heatTo + 2
            }
            networkService.setSetpoints(heatTo: heatTo, coolTo: coolTo)
        }
    }
    @AppStorage("coolTo") var coolTo: Int = 80 {
        didSet {
            if coolTo < heatTo + 2 {
                heatTo = coolTo - 2
            }
            networkService.setSetpoints(heatTo: heatTo, coolTo: coolTo)
        }
    }
    @AppStorage("mode") var mode: ModeSetting = .auto {
        didSet {
            networkService.setMode(mode: mode)
        }
    }
    @AppStorage("fanMode") var fanMode: FanSetting = .auto {
        didSet {
            networkService.setFan(fan: fanMode)
        }
    }
    
    func toggleFan() {
        fanMode = (fanMode == .auto) ? .on : .auto
    }
    
    // thermostat status
    @Published var spaceTemp: Double = 0.0
    @Published var thermostatState: CurrentState = .idle
    @Published var fanState: FanState = .off
    
    @Published var serverErrorMessage: String? = nil
    private var errorMessageTimer: Timer?
    func displayError(message: String?) {
        serverErrorMessage = message
        errorMessageTimer?.invalidate()
        errorMessageTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { [weak self] _ in
            self?.serverErrorMessage = nil
        }
    }
    
    var statusText: String {
        if !isConnected {
            return ""
        }
        
        var result: [String] = []
        
        result.append(self.awayMode == .away ? "Status: Away" : "Status: Home")
        
        let stateText = {
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
        }()
        
        if !(thermostatState == .idle && fanState == .on) {
            result.append(stateText)
        }
        
        if fanState == .on {
            result.append("Fans Running")
        }
        
        return result.joined(separator: ", ")
    }
    
    func refresh() {
        networkService.getDeviceStatus()
    }
    
    func updateStatus(status: DeviceStatus) {
        heatTo = Int(status.heattemp)
        coolTo = Int(status.cooltemp)
        spaceTemp = status.spacetemp
        thermostatState = status.state
        awayMode = {
            switch status.away {
            case 1:
                AwaySetting.away
            default:
                AwaySetting.home
            }
        }()
        fanState = {
            switch status.fanstate {
            case 1:
                FanState.on
            default:
                FanState.off
            }
        }()
    }
    
    @Published private var refreshTimer: AnyCancellable?
    func startRefreshTimer() {
        refreshTimer?.cancel()
        refreshTimer = nil
        
        refreshTimer = Timer.publish(every: 15, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.refresh()
            }
        refresh()
    }
    func stopRefreshTimer() {
        refreshTimer?.cancel()
        refreshTimer = nil
    }
    
    // network
    @Published var isConnected = false
    lazy var networkService: NetworkService = {
        return NetworkService(thermostat: self, settings: self.settings)
    }()
    
    // location
    @Published var awayMode: AwaySetting = .away {
        didSet {
            networkService.setLocation(location: awayMode)
        }
    }
}
