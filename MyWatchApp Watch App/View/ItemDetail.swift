//
//  ItemDetail.swift
//  MyWatchApp Watch App
//
//  Created by Toshiharu Imaeda on 2023/01/07.
//

import SwiftUI

struct ItemDetail: View {
    @Binding var item: ListItem

    var body: some View {
        Form {
            Section("List Item") {
                TextField("Item", text: $item.description, prompt: Text("List Item"))
            }

            Section("Completion") {
                Toggle(isOn: $item.isComplete) {
                    Text("Completed")
                }
            }

            Section("Estimating") {
                StepperView(levelIndex: $item.estimatedWork)
            }

            ShareLink(
                item: item.description,
                subject: Text("Please help!"),
                message: Text("(I need some help finishing this.)"),
                preview: SharePreview("\(item.description)")
            )
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle)
        }
        .navigationTitle(item.description)
    }
}

struct ItemDetail_Previews: PreviewProvider {
    @State static var item: ListItem = ListItem.init("hoge")

    static var previews: some View {
        NavigationStack {
            ItemDetail(item: $item)
        }
    }
}
