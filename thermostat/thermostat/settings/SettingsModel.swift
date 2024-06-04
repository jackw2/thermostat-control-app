//
//  Settings.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/3/24.
//

import Foundation

@Observable
class SettingsModel {
    static let standard = SettingsModel()
    private init() {}
    
    private let ud = UserDefaults.standard
    
    var banana = ""
    
    var serverURL: String {
        get {
            return ud.string(forKey: "serverURL") ?? ""
        }
        set {
            ud.set(newValue, forKey: "serverURL")
        }
    }
    
    var authSecret: String {
        get {
            ud.string(forKey: "authSecret") ?? ""
        }
        set {
            ud.set(newValue, forKey: "authSecret")
        }
    }
    
    var homeTitle: String {
        get {
            ud.string(forKey: "homeTitle") ?? "The White House"
        }
        set {
            ud.set(newValue, forKey: "homeTitle")
        }
    }
    
    var homeLatitude: Double {
        get {
            if let lat = ud.object(forKey: "homeLatitude") as? Double {
                return lat
            } else {
                return 38.897957
            }
        }
        set {
            ud.set(newValue, forKey: "homeLatitude")
        }
    }
    
    var homeLongitude: Double {
        get {
            if let long = ud.object(forKey: "homeLongitude") as? Double {
                return long
            } else {
                return -77.036560
            }
        }
        set {
            ud.set(newValue, forKey: "homeLongitude")
        }
    }
}
