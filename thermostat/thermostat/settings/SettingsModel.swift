//
//  Settings.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/3/24.
//

import Foundation
import Observation

@Observable
class SettingsModel {
    static let standard = SettingsModel()
    private init() {}
    
    private let ud = UserDefaults.standard
    
    var serverURL: String {
        get {
            self.access(keyPath: \.serverURL)
            return ud.string(forKey: "serverURL") ?? ""
        }
        set {
            self.withMutation(keyPath: \.serverURL) {
                ud.set(newValue, forKey: "serverURL")
            }
        }
    }
    
    var authSecret: String {
        get {
            self.access(keyPath: \.authSecret)
            return ud.string(forKey: "authSecret") ?? ""
        }
        set {
            self.withMutation(keyPath: \.authSecret) {
                ud.set(newValue, forKey: "authSecret")
            }
        }
    }
    
    var homeTitle: String {
        get {
            self.access(keyPath: \.homeTitle)
            return ud.string(forKey: "homeTitle") ?? "The White House"
        }
        set {
            self.withMutation(keyPath: \.homeTitle) {
                ud.set(newValue, forKey: "homeTitle")
            }
        }
    }
    
    var homeLatitude: Double {
        get {
            self.access(keyPath: \.homeLatitude)
            if let lat = ud.object(forKey: "homeLatitude") as? Double {
                return lat
            } else {
                return 38.897957
            }
        }
        set {
            self.withMutation(keyPath: \.homeLatitude) {
                ud.set(newValue, forKey: "homeLatitude")
            }
        }
    }
    
    var homeLongitude: Double {
        get {
            self.access(keyPath: \.homeLongitude)
            if let long = ud.object(forKey: "homeLongitude") as? Double {
                return long
            } else {
                return -77.036560
            }
        }
        set {
            self.withMutation(keyPath: \.homeLongitude) {
                ud.set(newValue, forKey: "homeLongitude")
            }
        }
    }
    
    var homeRadius: Int {
        get {
            self.access(keyPath: \.homeRadius)
            if let radius = ud.object(forKey: "homeRadius") as? Int {
                return radius
            } else {
                return 1
            }
        }
        set {
            self.withMutation(keyPath: \.homeRadius) {
                ud.set(newValue, forKey: "homeRadius")
            }
        }
    }
}
