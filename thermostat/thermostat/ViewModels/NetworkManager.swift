//
//  NetworkManager.swift
//  thermostat
//
//  Created by Jack Wesolowski on 5/22/24.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case unauthorized
    case networkError(Error)
    case invalidResponse
    case internalError
}

struct NetworkManager {
    private let userDefaults = UserDefaults.standard
    private var secret: String? = nil
    private var serverURL: String? = nil
    
//    init() {
//        
//    }
//    
//    func canAccessDefaultEndpoint(completion: @escaping (Bool) -> Void) {
//        guard let serverURL = serverURL else {
//            completion(false)
//            return
//        }
//        
//        AF.request(serverURL).response { (response: AFDataResponse<DecodableType>) in
//            if let statusCode = response.response?.statusCode, statusCode == 200 {
//                completion(true)
//            } else {
//                completion(false)
//            }
//        }
//    }
//    
    
    
    
//    static func setLocation(location: String, completion: @escaping (Result<String, ThermostatError>) -> Void) {
//        guard let url = URL(string: "\(baseURLString)/set_location") else {
//            completion(.failure(.invalidURL))
//            return
//        }
//        
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "POST"
//        urlRequest.addValue("your-secret-key", forHTTPHeaderField: "Authorization") // Replace with actual key
//        
//        let locationData = Data(location.utf8)
//        urlRequest.httpBody = locationData
//        
//        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//            if let error = error {
//                completion(.failure(.networkError(error)))
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse else {
//                completion(.failure(.invalidResponse))
//                return
//            }
//            
//            guard httpResponse.statusCode == 200 else {
//                completion(.failure(.unauthorized))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.failure(.invalidResponse))
//                return
//            }
//            
//            do {
//                let responseString = String(decoding: data, as: UTF8.self)
//                completion(.success(responseString))
//            } catch {
//                completion(.failure(.internalError))
//            }
//        }
//        
//        task.resume()
//    }
}
