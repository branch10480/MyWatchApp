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

    /// The index of the highlighted chart value. This is for crown scrolling. つまり、停止位置を表す
    @State private var highlightedDateIndex: Int = 0

    /// The current offset of the crown while it's rotating. This sample sets the offset the value in the DigitalCrownEvent and uses it to show an intermediate (between detents) chart value in the view.
    @State private var crownOffset: Double = 0.0
    @State private var isCrownIdle = true
    @State private var crownPositionOpacity: CGFloat = 0.2
    @State private var chartDataRange = (0...6)

    private var shortDateFormatStyle = DateFormatStyle(dateFormatTemplate: "Md")

    private func updateChartDataRange() {
        if (highlightedDateIndex - chartDataRange.lowerBound) < 2, chartDataRange.lowerBound > 0 {
            let newLowerBound = max(0, chartDataRange.lowerBound - 1)
            let newUpperBound = min(newLowerBound + 6, data.count - 1)
            chartDataRange = (newLowerBound...newUpperBound)
            return
        }
        if (chartDataRange.upperBound - highlightedDateIndex) < 2, chartDataRange.upperBound < data.count - 1 {
            let newUpperBound = min(chartDataRange.upperBound + 1, data.count - 1)
            let newLowerBound = max(0, newUpperBound - 6)
            chartDataRange = (newLowerBound...newUpperBound)
            return
        }
    }

    private var chartData: [ChartData.DataElement] {
        Array(data[chartDataRange.clamped(to: 0...data.count-1)])
    }

    private func isLastDataPoint(_ dataPoint: ChartData.DataElement) -> Bool {
        data[chartDataRange.upperBound].id == dataPoint.id
    }

    private var chart: some View {
        Chart(chartData) { dataPoint in
            BarMark(
                x: .value("Data", dataPoint.date, unit: .day),
                y: .value("Completed", dataPoint.itemComplete)
            )
            .foregroundStyle(Color.accentColor)
            .annotation(
                position: isLastDataPoint(dataPoint) ? .topLeading : .topTrailing,
                spacing: 0
            ) {
                Text("\(dataPoint.itemComplete, format: .number)")
                    .foregroundStyle(dataPoint.date == crownOffsetDate ? Color.yellow : Color.clear)
            }

            RuleMark(x: .value("Date", crownOffsetDate, unit: .day))
                .foregroundStyle(Color.yellow.opacity(crownPositionOpacity))
        }
        .chartXAxis {
            AxisMarks(format: shortDateFormatStyle)
        }
    }

    private var crownOffsetDate: Date {
        let dateDistance = data[0].date.distance(to: data[data.count - 1].date) * (crownOffset / Double(data.count - 1))
        return data[0].date.addingTimeInterval(dateDistance)
    }

    var body: some View {
        chart
            .focusable()
            .digitalCrownRotation(
                detent: $highlightedDateIndex,
                from: 0,
                through: data.count - 1,
                by: 1,
                sensitivity: .medium
            ) { crownEvent in
                isCrownIdle = false
                crownOffset = crownEvent.offset
            } onIdle: {
                isCrownIdle = true
            }
            .onChange(of: isCrownIdle) { newValue in
                withAnimation(newValue ? .easeOut : .easeIn) {
                    crownPositionOpacity = newValue ? 0.2 : 1.0
                }
            }
            .onChange(of: highlightedDateIndex) { newValue in
                withAnimation {
                    updateChartDataRange()
                }
            }
            .padding(.bottom, 15)
            .padding(.horizontal, 7)
            .edgesIgnoringSafeArea(.bottom)
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
