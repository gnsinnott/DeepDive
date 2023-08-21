//
//  DiveFlag.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 7/19/23.
//

import SwiftUI

struct DiveFlag: View {
    var width = 100.0
    var body: some View {
        let height = 50.0
        ZStack {
            Rectangle()
                .fill(.red)
            .frame(width: width, height: height)
            Rectangle()
                .fill(.white)
                .frame(width: sqrt(pow(width,2)+pow(height,2)), height: (height * 0.25))
                .rotationEffect(.degrees(30))
                
        }
        .frame(width: width, height: height)
        .clipShape(Rectangle())
    }
}

#Preview {
    DiveFlag()
}
