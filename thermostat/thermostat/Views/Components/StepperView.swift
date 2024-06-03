//
//  SetpointView.swift
//  thermostat
//
//  Created by Jack Wesolowski on 5/19/24.
//

import SwiftUI

struct StepperView: View {
    private let buttonFont: Font = .system(size: 24, weight: .bold)
    @Binding var setpoint: Int
    var gradientColors: [Color]
    var foregroundColor: Color = .white
    
    var body: some View {
        VStack(spacing: 4) {
            Button(action: {
                setpoint += 1
            }) {
                Image(systemName: "plus")
                    .font(buttonFont)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            Divider()
            Text("\(setpoint)")
                .font(.system(size: 36, weight: .bold))
                .frame(maxHeight: .infinity)
            Divider()
            
            Button(action: {
                setpoint -= 1
            }) {
                Image(systemName: "minus")
                    .font(buttonFont)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxHeight: .infinity)
        }
        .frame(width: 80, height: 200)
        .background(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .bottom, endPoint: .top))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .foregroundStyle(foregroundColor)
        .padding()
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var setpoint: Int = 72
        
        var body: some View {
            return StepperView(setpoint: $setpoint, gradientColors: [.heat, .blush])
        }
    }
    return PreviewWrapper()
}
