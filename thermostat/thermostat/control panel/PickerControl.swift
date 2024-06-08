//
//  ModePicker.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/8/24.
//

import Foundation
import SwiftUI

struct PickerControl<T: CaseIterable & Identifiable & Hashable & CustomStringConvertible>: View {
    @Binding var pickedValue: T
    var title: String
    var systemImage: String
    
    var body: some View {
        HStack(spacing: 0) {
            Label(title, systemImage: systemImage)
            Picker(title, selection: $pickedValue)  {
                ForEach(Array(T.allCases)) { option in
                    Text(option.description).tag(option)
                }
            }
            .pickerStyle(.menu)
        }
        .frame(minWidth: 160)
    }
}


#Preview {
    enum TestEnum: String, CaseIterable, CustomStringConvertible, Identifiable {
        case apple = "appl"
        case banana = "bana"
        
        var id: Self { self }
        var description: String {
            self.rawValue.capitalized
        }
    }
    
    struct PreviewWrapper: View {
        @State var enumValue: TestEnum = .apple

        var body: some View {
            ZStack {
                Rectangle()
                    .fill(.highlightBackground)
                PickerControl(pickedValue: $enumValue, title: "Mode", systemImage: "fan")
                    
            }
        }
    }
    return PreviewWrapper()
}
