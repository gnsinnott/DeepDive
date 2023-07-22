//
//  DiveFlag.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 7/19/23.
//

import SwiftUI

struct DiveFlag: View {
    var body: some View {
        let width = 400.0
        let height = width
        ZStack {
            Rectangle()
                .fill(.red)
            .frame(width: width, height: height)
            Rectangle()
                .fill(.white)
                .frame(width: sqrt(pow(width,2)+pow(height,2)), height: (height * 0.25))
                .rotationEffect(.degrees(45))
            Rectangle()
                .stroke(lineWidth: width/20)
                .fill(.red)
                .frame(width: width, height: height)
                
        }
        .frame(width: width, height: height)
        .clipShape(Rectangle())
    }
}

#Preview {
    DiveFlag()
}
