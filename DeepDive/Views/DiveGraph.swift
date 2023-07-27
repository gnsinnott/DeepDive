//
//  DiveGraph.swift
//  DeepDive
//
//  Created by Gregory Sinnott on 7/24/23.
//

import SwiftUI
import Charts

struct dataPoint: Identifiable {
    var id: UUID
    var index: Int
    var value: Double
    var text: String
    var position: Alignment
    
    init(index: Int, value: Double, text: String, position: Alignment) {
        self.id = UUID()
        self.index = index
        self.value = value
        self.text = text
        self.position = position
    }
}

var data: [dataPoint] = [
    dataPoint(index: 0, value: 10, text: "3000 psi", position: .bottom),
    dataPoint(index: 1, value: 10, text: "", position: .bottom),
    dataPoint(index: 2, value: 0, text:"", position: .top),
//    dataPoint(index: 3, value: 0, text:"34m", position: .top),
    dataPoint(index: 4, value: 0, text:"", position: .top),
    dataPoint(index: 5, value: 10, text: "", position: .bottom),
    dataPoint(index: 6, value: 10, text: "1200 psi", position: .bottom),
]

struct DiveGraph: View {
    
    let data = [10, 10, 0, 0, 10, 10]
    var body: some View {
        VStack {
            Chart(DeepDive.data) {
                LineMark(
                    x: .value("", $0.index ),
                    y: .value("", $0.value))
                PointMark(
                    x: .value("", $0.index ),
                    y: .value("", $0.value))
                .annotation(position: .overlay, alignment: $0.position, spacing: 10){
                    Text("Test:")
                    }
                }.frame(width:300, height: 150)
            
            Chart{
                ForEach(Array(data.enumerated()), id: \.offset) { index, value in
                    LineMark(x: .value("index", index), y:
                            .value("Value", value))
                    PointMark(x: .value("index", index), y:
                            .value("Value", value))
                    .annotation(position: .overlay, alignment: .top, spacing: 10){
                        Text("\(value)")
                    }
                }
            }.frame(width:300, height: 150)
            diveGraph()
                .stroke(.blue, lineWidth: 4)
                .frame(width: 300, height: 150)
                .padding()
        }
    }
}

struct diveGraph: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX/4, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX/3, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX/3*2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX/4*3, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        return path
    }
}
#Preview {
    DiveGraph()
}
