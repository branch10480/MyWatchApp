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

    private var crownOffsetDate: Date {
        let dateDistance = data[0].date.distance(to: data[data.count - 1].date) * (crownOffset / Double(data.count - 1))
        return data[0].date.addingTimeInterval(dateDistance)
    }

    /// The index of the highlighted chart value. This is for crown scrolling. つまり、停止位置を表す
    @State private var highlightedDateIndex: Int = 0

    /// The current offset of the crown while it's rotating. This sample sets the offset the value in the DigitalCrownEvent and uses it to show an intermediate (between detents) chart value in the view.
    @State private var crownOffset: Double = 0.0
    @State private var isCrownIdle = true
    @State private var crownPositionOpacity: CGFloat = 0.2

    private var chart: some View {
        Chart(data) { dataPoint in
            BarMark(
                x: .value("Data", dataPoint.date),
                y: .value("Completed", dataPoint.itemComplete)
            )
            .foregroundStyle(Color.accentColor)

            RuleMark(x: .value("Date", crownOffsetDate))
                .foregroundStyle(Color.yellow.opacity(crownPositionOpacity))
        }
        .chartXAxis {
            AxisMarks(format: .dateTime.day().month().year())
        }
        .onChange(of: isCrownIdle, perform: { newValue in
            withAnimation(newValue ? .easeOut : .easeIn) {
                crownPositionOpacity = newValue ? 0.2 : 1.0
            }
        })
        .navigationTitle("Productivity")
        .navigationBarTitleDisplayMode(.inline)
    }

    var body: some View {
        chart
            .focusable()
            .digitalCrownRotation(
                detent: $highlightedDateIndex,
                from: 0,
                through: data.count - 1,
                by: 1
            ) { crownEvent in
                isCrownIdle = false
                crownOffset = crownEvent.offset
            } onIdle: {
                isCrownIdle = true
            }
    }
}

struct ProductivityChart_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductivityChart()
        }
    }
}
