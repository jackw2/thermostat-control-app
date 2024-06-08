//
//  KeychainUtility.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/8/24.
//
import Foundation
import Security

struct KeychainUtility {
    static func savePassword(_ password: String, for account: String) {
        let data = Data(password.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary) // Delete existing item if it exists
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status != errSecSuccess {
            print("Error saving password: \(status)")
        }
    }
    
    static func getPassword(for account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess, let data = item as? Data else {
            print("Error retrieving password: \(status)")
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
}
