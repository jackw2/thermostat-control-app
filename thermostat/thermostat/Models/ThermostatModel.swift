//
//  ThermostatModel.swift
//  thermostat
//
//  Created by Jack Wesolowski on 5/21/24.
//

import Foundation



let AWAY_HOME: AwayMode = .home

class ThermostatModel {
    private var statusInfo: [String: Any?] = [
        "state": nil,
        "away": nil,
        "spacetemp": nil,
        "heattemp": nil,
        "cooltemp": nil,
    ]
    
    var location = AwayMode.home
    var setpointHeatTo = 70
    var setpointCoolTo = 80
    var mode = Mode.auto
    var fan = Fan.auto
    
    
    static let shared: ThermostatModel = {
        let instance = ThermostatModel()
        
        return instance
    }()
    
    private init() {
        // Private initializer to prevent multiple instances of singleton
    }
}
