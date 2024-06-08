//
//  StepperControl.swift
//  thermostat
//
//  Created by Jack Wesolowski on 5/19/24.
//

import SwiftUI

struct StepperControl: View {
    @Binding var setpoint: Int
    var darkColor: Color
    var lightColor: Color
    var foregroundColor: Color = .white
    var neomorphismInset = true

    private let cornerRadius = 10.0
    private let buttonFont: Font = .system(size: 24, weight: .bold)
    private let width = 80.0
    private let height = 200.0

    func neomorphismShadow(fillColor: Color, offset: CGFloat) -> some View {
        let radius = 10.0
        return (
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(fillColor)
                .frame(width: width + radius, height: height + radius)
                .blur(radius: radius)
                .offset(x: offset, y: offset)
                .blendMode(.overlay)
        )
    }

    var body: some View {
        ZStack {
            if (neomorphismInset) {
                neomorphismShadow(fillColor: Color.white.opacity(0.7), offset: -5)
                neomorphismShadow(fillColor: Color.black.opacity(0.2), offset: 10)
            }
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
            .frame(width: width, height: height)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [darkColor, lightColor]), startPoint: .bottom, endPoint: .top)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .foregroundStyle(foregroundColor)
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var setpoint: Int = 72

        var body: some View {
            ZStack {
                Rectangle()
                    .fill(.highlightBackground)
                VStack {
                    StepperControl(setpoint: $setpoint, darkColor: .heat, lightColor: .blush)
                        .padding()
                    StepperControl(setpoint: $setpoint, darkColor: .heat, lightColor: .blush, neomorphismInset: false)
                }
            }
        }
    }
    return PreviewWrapper()
}
