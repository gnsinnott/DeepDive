//
//  WeightImage.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 7/27/23.
//

import SwiftUI

struct WeightImage: View {
    var weight = 14
    var unit = false
    var body: some View {
        if weight > 0 {
            VStack(spacing: 8){
                ForEach((1...weight/(unit ? 2 : 4)), id: \.self) { index in
                    ZStack {
                        Trapezoid(base: 40*Double(index)+20, top: 40*Double(index-1)+20, height: 25.0)
                            .stroke(.gray, style: StrokeStyle(lineWidth: 4.0, lineCap: .round))
                            .fill(.gray)
                            .frame(width: 40*Double(index), height: 25)
                    }
                }
                Text("\(weight) \(unit ? "kg" : "lb")")
            }
        }
        else {
            Text("No weight")
        }
    }
}

struct Trapezoid: Shape {
    var base = 100.0
    var top = 33.3
    var height = 40.0
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: base, y: height))
        path.addLine(to: CGPoint(x: (base-top)/2+top, y: 0))
        path.addLine(to: CGPoint(x: (base-top)/2, y: 0))
        path.addLine(to: CGPoint(x: 0, y: height))
        return path
    }
}

#Preview {
    WeightImage()
}
