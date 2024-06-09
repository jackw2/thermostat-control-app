//
//  NetworkService.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/8/24.
//
import Foundation
import Alamofire
import Combine

class NetworkService {
    var thermostat: ThermostatModel
    init(thermostat: ThermostatModel) {
        self.thermostat = thermostat
    }
    
    private var settings: SettingsModel = SettingsModel.shared
    private var serverURL: String {
        return settings.serverURL
    }
    private var defaultHeaders: [String: String] {
        ["Authorization": settings.authSecret, "Content-Type": "application/json"]
    }
    

    
    
}
