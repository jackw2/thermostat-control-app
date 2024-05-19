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

    var body: some View {
        VStack {
            Text("Current Temp")
                .font(.system(size: 24, weight: .medium))
            Text("\(currentTemp, specifier: "%.1f")°F")
                .font(.system(size: 72, weight: .medium))
            HStack {
                StepperView(setpoint: $heatSetpoint, gradientColors: [.heat, .blush])
                StepperView(setpoint: $coolSetpoint, gradientColors: [.bunny, .wind])
            }
        }
        .padding()
    }
}

#Preview {
    ControlPanelView()
}
