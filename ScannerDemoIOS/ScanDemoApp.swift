//
//  ScanDemoApp.swift
//  ScanDemo
//
//  Created by Muhammad Tohirov on 20/05/25.
//

import SwiftUI

@main
struct ScanDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
