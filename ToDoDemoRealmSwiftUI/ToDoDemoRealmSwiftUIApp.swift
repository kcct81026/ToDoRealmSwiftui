//
//  ToDoDemoRealmSwiftUIApp.swift
//  ToDoDemoRealmSwiftUI
//
//  Created by Kcct on 09/12/2024.
//

import SwiftUI

@main
struct ToDoDemoRealmSwiftUIApp: App {
    private let appData = ApplicationData.shared

    var body: some Scene {
        WindowGroup {
            //ContentView()
            SearchContentView()
                .environment(appData)
        }
    }
}
