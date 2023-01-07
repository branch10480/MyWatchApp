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

    init(_ description: String) {
        self.description = description
    }
}
