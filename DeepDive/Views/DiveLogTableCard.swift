//
//  DiveLogTableCard.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 7/11/23.
//

import SwiftUI

struct DiveLogTableCard: View {
    var body: some View {
        var width = CGFloat(80)
        var thickness = CGFloat(3)
        var height = CGFloat(100)
        ZStack{
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    Text("8:45 PM")
                    Rectangle() // -
                        .frame(width: width, height: thickness)
                    Text("3000 PSI")
                }
                Rectangle() // |
                    .frame(width: thickness, height: height)
                    .padding(.top, (height-thickness))
                VStack(spacing: 0) {
                    Text("34m")
                    Rectangle() // _
                        .frame(width: (width-2*thickness)*2, height: thickness)
                    .padding(.top, (height*2-thickness*2))
                    
                }
                Rectangle() // |
                    .frame(width: thickness, height: height)
                    .padding(.top, (height-thickness))
                VStack(spacing: 0) {
                    Text("9:25 PM")
                    Rectangle() // -
                        .frame(width: width, height: thickness)
                    Text("300 PSI")
                }
            }
            .foregroundStyle(Color.blue)
        }
    }
}

#Preview {
    DiveLogTableCard()
}
