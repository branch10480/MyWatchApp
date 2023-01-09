//
//  ProductivityChart.swift
//  MyWatchApp Watch App
//
//  Created by Toshiharu Imaeda on 2023/01/07.
//

import SwiftUI
import Charts

struct ProductivityChart: View {
    private let data = ChartData.chartSampleData

    var body: some View {
        Chart(data) { dataPoint in
            BarMark(
                x: .value("Data", dataPoint.date),
                y: .value("Completed", dataPoint.itemComplete)
            )
            .foregroundStyle(Color.accentColor)
        }
        .chartXAxis {
            AxisMarks(format: .dateTime.day().month().year())
        }
        .navigationTitle("Productivity")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProductivityChart_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductivityChart()
        }
    }
}
