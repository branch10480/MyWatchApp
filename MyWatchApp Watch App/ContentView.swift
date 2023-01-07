//
//  ContentView.swift
//  MyWatchApp Watch App
//
//  Created by Toshiharu Imaeda on 2023/01/07.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var model: ItemListModel

    var body: some View {
        List {
            ForEach($model.items) { $item in
                Text(item.description)
            }

            if model.items.isEmpty {
                Text("No items to do!")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Tasks")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var itemListModel = ItemListModel()

    static var previews: some View {
        ContentView()
            .environmentObject(itemListModel)
    }
}
