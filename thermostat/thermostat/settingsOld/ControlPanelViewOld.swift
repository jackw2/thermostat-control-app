//
//  Control.swift
//  thermostat
//
//  Created by Jack Wesolowski on 5/19/24.
//

import SwiftUI

struct ControlPanelViewOld: View {
    @State private var currentTemp: Double = 72.0
    @State private var heatSetpoint = 70
    @State private var coolSetpoint = 80
    @State private var count = 0
    @State private var isConnected = true
    
    @Environment(SettingsModelOld.self) private var settingsModel
    @State private var thermostatModel = ThermostatModelOld.standard
    
    var body: some View {
        VStack() {
//            ConnectionIndicatorView(isConnected: $isConnected)
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
                StepperControl(setpoint: $heatSetpoint, darkColor: .heat, lightColor: .blush)
                    .padding()
                StepperControl(setpoint: $coolSetpoint, darkColor: .bunny, lightColor: .wind)
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
        @State private var settingsModel = SettingsModelOld.standard
        
        var body: some View {
            ControlPanelViewOld()
                .environment(settingsModel)
        }
    }
    return PreviewWrapper()
}