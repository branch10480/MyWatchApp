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
        .toolbar {
            AddItemLink()
                .padding(.bottom)
        }
        .navigationTitle("Tasks")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var itemListModel = ItemListModel.demo

    static var previews: some View {
        NavigationStack {
            ContentView()
                .environmentObject(itemListModel)
        }
    }
}
