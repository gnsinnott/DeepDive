//
//  DiveDetail.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 6/14/23.
//

import SwiftUI
import SwiftData

struct DiveDetail: View {
    var dive: Dive
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Text(dive.name)
    }
}

//#Preview {
//    DiveDetail(dive: Dive(name: "Try", depth: 12))
//}
