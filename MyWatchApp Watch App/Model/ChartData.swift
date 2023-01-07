//
//  ChartData.swift
//  MyWatchApp Watch App
//
//  Created by Toshiharu Imaeda on 2023/01/07.
//

import Foundation

struct ChartData {
    struct DataElement: Identifiable {
        var id: Date { date }
        var date: Date
        var itemComplete: Double
    }

    static func createData(_ items: [ListItem]) -> [DataElement] {
        return Dictionary(grouping: items, by: \.completionDate)
            .compactMap {
                guard let date = $0 else { return nil }
                return DataElement(date: date, itemComplete: Double($1.count))
            }
            .sorted {
                $0.date < $1.date
            }
    }
}
