//
//  SettingsView.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 7/26/23.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var presentAlert = false
    @State private var displayDiveNumber = 1
    @AppStorage("defaultUnit") var defaultUnit = true
    @AppStorage("diveNumber") var diveNumber = 1
    
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
                Text("Next Dive Number: \(diveNumber)")
                Button("Change Dive Number"){
                    presentAlert = true
                }
                
                .alert("Dive Number", isPresented: $presentAlert, actions: {
                    TextField("Starting Dive Number", value: $displayDiveNumber, format: .number)
                        .keyboardType(.numberPad)
                    Button("Set", action: {
                        diveNumber = displayDiveNumber
                    })
                    Button("Cancel", role: .cancel, action: {})
                })
            }
            Text("About")
                .font(.title)
            Text("Developed by: Gregory Sinnott")
        }
        .onAppear(){
            displayDiveNumber = diveNumber
        }
    }
}



#Preview {
    SettingsView()
}
