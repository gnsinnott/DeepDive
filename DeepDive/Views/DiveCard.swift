//
//  DiveCard.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/9/23.
//

import SwiftUI
import SwiftData

struct DiveCard: View {    
    var dive: Dive
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.cyan)
            VStack {
                HStack {
                    VStack {
                        Text("🤿 1: \(dive.name)")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        Text("Roatan")
                    }
            
                    VStack {
                        Text(dive.date, style: .date)
                        Text(dive.date, style: .time)
                    }
//                    .font(.caption)
                    .padding()
                }
                HStack{
                    VStack{
                        Text("\(dive.depth) ft")
                        Text("\(dive.duration) min")
                        Text("Oxygen 🚤")
                    }
                }
            }
        }
        .padding()
        .frame(height: 200)
    }
}

#Preview {
    MainActor.assumeIsolated {
        let container = previewContainer
           return DiveCard(dive: Dive.preview)
                .modelContainer(container)
    }
}
