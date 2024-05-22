//
//  ThermostatEnums.swift
//  thermostat
//
//  Created by Jack Wesolowski on 5/22/24.
//

import Foundation

enum Mode: Int {
    case off = 0
    case heat = 1
    case cool = 2
    case auto = 3
}

enum CurrentState: Int {
    case idle = 0
    case heating = 1
    case cooling = 2
    case lockout = 3
    case error = 4
}

enum Fan: Int {
    case auto = 0
    case on = 1
}

enum FanState: Int {
    case off = 0
    case on = 1
}

enum TempUnits: Int {
    case fahrenheit = 0
    case celsius = 1
}

enum Security: Int {
    case off = 0
    case on = 1
}

enum ScheduleFormat: Int {
    case fahrenheit = 0
    case celsius = 1
}

enum SchedulePart: Int {
    case morning = 0
    case day = 1
    case evening = 2
    case night = 3
    case inactive = 255
}

enum AwayMode: Int {
    case home = 0
    case away = 1
}
