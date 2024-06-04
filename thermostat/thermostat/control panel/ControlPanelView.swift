//
//  Control.swift
//  thermostat
//
//  Created by Jack Wesolowski on 5/19/24.
//

import SwiftUI

struct ControlPanelView: View {
    @State private var currentTemp: Double = 72.0
    @State private var heatSetpoint = 70
    @State private var coolSetpoint = 80
    @State private var count = 0
    @State private var isConnected = true
    
    @Environment(SettingsModel.self) private var settingsModel
    @State private var thermostatModel = ThermostatModel.standard
    
    var body: some View {
        VStack() {
            ConnectionIndicatorView(isConnected: $isConnected)
            Group {
                VStack {
                    Text(settingsModel.homeTitle)
                        .frame(alignment: .top)
                        .lineLimit(1)
                        .font(.system(size: 24, weight: .medium))
                    Text("\(currentTemp, specifier: "%.1f")°F")
                        .font(.system(size: 72, weight: .medium))
                }
            }
            .frame(maxWidth: .infinity, minHeight: 300, maxHeight: 500)
            
            HStack {
                StepperView(setpoint: $heatSetpoint, gradientColors: [.heat, .blush])
                    .padding()
                StepperView(setpoint: $coolSetpoint, gradientColors: [.bunny, .wind])
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.highlightBackground)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var settingsModel = SettingsModel.standard
        
        var body: some View {
            ControlPanelView()
                .environment(settingsModel)
        }
    }
    return PreviewWrapper()
}
