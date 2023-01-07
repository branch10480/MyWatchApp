//
//  ItemListModel.swift
//  MyWatchApp Watch App
//
//  Created by Toshiharu Imaeda on 2023/01/07.
//

import Foundation

class ItemListModel: NSObject, ObservableObject {
    @Published var items = [ListItem]()

    static let demo = ItemListModel(items: [
        .init("hoge"),
        .init("foge"),
        .init("loge"),
        .init(";oge"),
        .init("soge"),
        .init("oge"),
        .init("e")
    ])

    init(items: [ListItem] = [ListItem]()) {
        self.items = items
    }
}
