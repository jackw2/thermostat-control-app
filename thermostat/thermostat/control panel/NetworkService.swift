//
//  NetworkService.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/8/24.
//
import Foundation
import Alamofire
import Combine

struct GeneralResponse: Codable {
    let message: String?
}

struct DeviceStatus: Codable {
    let heattemp: Double
    let cooltemp: Double
    let spacetemp: Double
    let state: CurrentState
    let away: Int
    let fanstate: Int
}

class NetworkService {
    private let thermostat: ThermostatModel
    private let settings: SettingsModel
    private var connectionCheckTimer: Timer?
    private var serverURL: String {
        return settings.serverURL
    }
    private var defaultHeaders: HTTPHeaders {
        return [
            "Authorization": settings.authSecret,
            "Content-Type": "application/json"
        ]
    }
    
    init(thermostat: ThermostatModel, settings: SettingsModel) {
        self.thermostat = thermostat
        self.settings = settings
        startConnectionCheckTimer()
    }
    deinit {
        connectionCheckTimer?.invalidate()
    }
    
    // MARK: Limiting guards
    func serverNotSetupYet() -> Bool {
        return serverURL == ""
    }
    
    func shouldRateLimit(lastRequestTime: inout Date?, rateLimitSeconds: Double = 10.0, _ callerName: String = #function) -> Bool {
        if let lastRequestTime = lastRequestTime, Date().timeIntervalSince(lastRequestTime) < rateLimitSeconds {
            print("\(callerName):: request rate limited")
            return true
        }
        lastRequestTime = Date()
        return false
    }
    
    // MARK: Get
    func checkConnection() {
        AF.request("\(serverURL)/", headers: defaultHeaders).validate().response { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                    print("Connected to " + self.serverURL)
                    self.thermostat.isConnected = true
                case .failure:
                    self.thermostat.isConnected = false
                }
            }
        }
    }
    
    private var lastDeviceStatusRequestTime: Date?
    func getDeviceStatus() {
        
        guard serverNotSetupYet() &&
        shouldRateLimit(lastRequestTime: &lastDeviceStatusRequestTime, rateLimitSeconds: 10) else {
            return
        }
        
        let url = serverURL + "/device_status"
        
        AF.request(url, method: .get, headers: defaultHeaders).validate().responseDecodable(of: DeviceStatus.self) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let data):
                print("Device Status: \(data)")
                thermostat.updateStatus(status: data)
            case .failure(let error):
                print(error)
                thermostat.displayError(message: error.errorDescription)
                invalidateConnection()
            }
        }
    }
    
    // MARK: Set controls
    func postWithAuthorization(url: String, parameters: [String: Any]) {
        guard serverNotSetupYet() else {
            return
        }
        
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: defaultHeaders).validate().responseDecodable(of: GeneralResponse.self) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let data):
                if let message = data.message {
                    print(message)
                }
            case .failure(let error):
                print(error)
                thermostat.displayError(message: error.errorDescription)
                invalidateConnection()
            }
        }
    }
    
    func setSetpoints(heatTo: Int, coolTo: Int) {
        let url = serverURL + "/set_setpoints"
        let parameters: [String: Any] = [
            "heat_to": heatTo,
            "cool_to": coolTo,
        ]
        
        postWithAuthorization(url: url, parameters: parameters)
    }
    
    func setMode(mode: ModeSetting) {
        let url = serverURL + "/set_mode"
        let parameters: [String: Any] = [
            "mode": mode,
        ]
        
        postWithAuthorization(url: url, parameters: parameters)
    }
    
    func setFan(fan: FanSetting) {
        let url = serverURL + "/set_fan"
        let parameters: [String: Any] = [
            "fan": fan,
        ]
        
        postWithAuthorization(url: url, parameters: parameters)
    }
    
    func setLocation(location: AwaySetting) {
        let url = serverURL + "/set_location"
        let parameters: [String: Any] = [
            "location": location,
        ]
        
        print("Attempting to set location: \(location)")
        
        postWithAuthorization(url: url, parameters: parameters)
    }
    
    // Mark: Connection status
    private func invalidateConnection() {
        thermostat.isConnected = false
        startConnectionCheckTimer()
    }
    
    private func startConnectionCheckTimer(seconds: Double = 10.0) {
        self.connectionCheckTimer?.invalidate()
        self.connectionCheckTimer = nil
        
        connectionCheckTimer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.checkConnection()
            if self.thermostat.isConnected {
                self.connectionCheckTimer?.invalidate()
                self.connectionCheckTimer = nil
            }
        }
        connectionCheckTimer?.fire()
    }
}
