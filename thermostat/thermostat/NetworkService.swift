//
//  NetworkService.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/8/24.
//
import Foundation
import Alamofire
import Combine

struct GeneralGetResponse: Codable {
    let message: String?
}

class NetworkService {
    var thermostat: ThermostatModel
    private var settings: SettingsModel = SettingsModel.shared
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
    
    init(thermostat: ThermostatModel) {
        self.thermostat = thermostat
        startConnectionCheckTimer()
    }
    deinit {
        connectionCheckTimer?.invalidate()
    }
    
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
    
    
    func setLocation(location: String) {
        let url = serverURL + "/set_location"
        let parameters: [String: Any] = ["location": location]
        
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: defaultHeaders).validate().responseDecodable(of: GeneralGetResponse.self) { [weak self] response in
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
        
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: defaultHeaders).validate().responseDecodable(of: GeneralGetResponse.self) { [weak self] response in
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
