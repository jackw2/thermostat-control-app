//
//  ThermostatModel.swift
//  thermostat
//
//  Created by Jack Wesolowski on 5/21/24.
//

import Foundation

@Observable
class ThermostatModel {
    static let standard = ThermostatModel()
    private init() {}
    
    var statusInfo: [String: Any?] = [
        "state": nil,
        "away": nil,
        "spacetemp": nil,
        "heattemp": nil,
        "cooltemp": nil,
    ]
//    var currentTemp: Double = 72.0
//    var heatSetpoint = 70
//    var coolSetpoint = 80
//    var count = 0
//    var isConnected = true
    
    
    var location = AwayMode.home
    var setpointHeatTo = 70
    var setpointCoolTo = 80
    var mode = Mode.auto
    var fan = Fan.auto
}
