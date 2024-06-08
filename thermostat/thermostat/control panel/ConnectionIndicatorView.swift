//
//  ConnectionIndicatorView.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/3/24.
//

import Foundation
import SwiftUI

struct ConnectionIndicatorView: View {
    var isConnected: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            if isConnected {
                Image(systemName: "wifi")
                    .foregroundColor(.green)
                Text("Connected")
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                Text("Connecting")
            }
        }
        .padding(10)
        .frame(minWidth: 200)
        .background(.highlightBackground)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}



#Preview {
    struct PreviewWrapper: View {
        @State private var isConnected = true
        
        var body: some View {
            ConnectionIndicatorView(isConnected: isConnected)
        }
    }
    return PreviewWrapper()}
