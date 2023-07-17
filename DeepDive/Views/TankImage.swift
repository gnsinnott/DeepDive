//
//  TankImage.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 7/10/23.
//

import SwiftUI

struct TankImage: View {
    var start: Int
    var end: Int
    var airType: String
    var tankSize: Int
    var tankSizeUnit: Bool
    
    var body: some View {
        let height: CGFloat = CGFloat(Double(end)/Double(start))
        VStack(spacing: 0)
        {
            if (start < end || start == 0){
                Text("Invalid tank pressures")
            } else {
                ZStack {
                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: 25, bottomLeading: 0, bottomTrailing: 0, topTrailing: 25))
                                    .fill(.gray)
                                    .frame(width: 50, height: min(200,min(200*(1-height), 180)))
                                .padding(0)
                    Text(String(start))
                }
                ZStack {
                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: 0, bottomLeading: 10, bottomTrailing: 10, topTrailing: 0))
                                    .fill(.yellow)
                                    .frame(width: 50, height: min(200,max(200*height, 21)))
                                .padding(0)
                    Text(String(end))
                }
                Text(airType)
                if (tankSize > 0){
                    Text(String(tankSize) + (tankSizeUnit ? " L" : " cu ft"))
                }
            }
        }
    }
}

#Preview {
    TankImage(start: 4000, end: 500, airType: "Air", tankSize: 20, tankSizeUnit: true)
}
