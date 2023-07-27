//
//  SettingsView.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 7/26/23.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("defaultUnit") var defaultUnit = true

    var body: some View {
        VStack {
            Text("Settings")
                .font(.title)
            DiveFlag(width: 100)
            Form {
                Text("Default Unit")
                Picker("Default Unit", selection: $defaultUnit) {
                    Text("meters").tag(true)
                    Text("feet").tag(false)
                        }
                .pickerStyle(.segmented)
            }
            Text("About")
                .font(.title)
            Text("Developed by: Gregory Sinnott")
        }
    }
}

#Preview {
    SettingsView()
}
