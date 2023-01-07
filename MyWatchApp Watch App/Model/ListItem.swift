//
//  ListItem.swift
//  MyWatchApp Watch App
//
//  Created by Toshiharu Imaeda on 2023/01/07.
//

import Foundation

struct ListItem: Identifiable, Hashable {
    let id = UUID()
    var description: String
    var estimatedWork: Int = 2
    var creationDate: Date = Date()
    var completionDate: Date?

    var isComplete: Bool {
        get {
            completionDate != nil
        }
        set {
            completionDate = Date()
        }
    }

    init(_ description: String) {
        self.description = description
    }
}
