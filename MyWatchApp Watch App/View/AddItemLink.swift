//
//  AddItemLink.swift
//  MyWatchApp Watch App
//
//  Created by Toshiharu Imaeda on 2023/01/07.
//

import SwiftUI

struct AddItemLink: View {
    @EnvironmentObject private var model: ItemListModel

    var body: some View {
        VStack {
            TextFieldLink(prompt: Text("New Item")) {
                Label("Add", systemImage: "plus.circle.fill")
            } onSubmit: { text in
                model.items.append(.init(text))
            }
            .buttonStyle(.borderedProminent)
            .frame(width: .infinity)
        }
        .navigationTitle("Tasks")
    }
}

struct AddItemLink_Previews: PreviewProvider {
    static var model = ItemListModel()

    static var previews: some View {
        NavigationStack {
            AddItemLink()
                .environmentObject(model)
        }
    }
}
