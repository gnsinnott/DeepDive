//
//  DayNighToggleStyle.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/28/23.
//

import SwiftUI

struct DayNightToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                configuration.label.tint(.primary)
                Image(systemName: configuration.isOn ? "moon" : "sun.max")
                    .foregroundStyle(configuration.isOn ? Color.blue : .orange)
                    .accessibility(label: Text(configuration.isOn ? "Night Dive" : "Day Dive"))
                    .imageScale(.large)
            }
        }
    }
}
