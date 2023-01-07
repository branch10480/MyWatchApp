//
//  ItemListModel.swift
//  MyWatchApp Watch App
//
//  Created by Toshiharu Imaeda on 2023/01/07.
//

import Foundation

class ItemListModel: NSObject, ObservableObject {
    @Published var items = [ListItem]()
}
