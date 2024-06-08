//
//  ControlPanelView.swift
//  thermostat
//
//  Created by Jack Wesolowski on 5/19/24.
//

import SwiftUI

struct ControlPanelView: View {
    @EnvironmentObject var settings: SettingsModel
    @StateObject var thermostat: ThermostatModel = ThermostatModel()
    var body: some View {
        VStack {
            ConnectionIndicatorView(isConnected: thermostat.isConnected)
            VStack {
                Text(settings.homeTitle)
                    .frame(alignment: .top)
                    .lineLimit(1)
                    .font(.system(size: 24, weight: .medium))
                Text("\(String(format: "%.1f", thermostat.spaceTemp))°F")
                    .font(.system(size: 72, weight: .medium))
            }
            .frame(maxWidth: .infinity, minHeight: 300, maxHeight: 500)
            
            Text("Status: " + thermostat.statusText)
            VStack {
                HStack {
                    PickerControl(pickedValue: $thermostat.fanMode, title: "Fan", systemImage: "fan")
                    PickerControl(pickedValue: $thermostat.mode, title: "Mode", systemImage: "gearshape")
                }
                HStack {
                    StepperControl(setpoint: $thermostat.heatTo, darkColor: .heat, lightColor: .blush)
                        .padding()
                    StepperControl(setpoint: $thermostat.coolTo, darkColor: .bunny, lightColor: .wind)
                        .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.highlightBackground)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @StateObject private var settings = SettingsModel.shared
        
        var body: some View {
            ControlPanelView()
                .environmentObject(settings)
        }
    }
    return PreviewWrapper()
}
