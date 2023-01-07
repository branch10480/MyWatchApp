//
//  MyWatchAppApp.swift
//  MyWatchApp Watch App
//
//  Created by Toshiharu Imaeda on 2023/01/07.
//

import SwiftUI

@main
struct MyWatchApp_Watch_AppApp: App {
    @StateObject var itemListModel = ItemListModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environmentObject(itemListModel)
            }
        }
    }
}
