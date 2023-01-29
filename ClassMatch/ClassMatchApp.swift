//
//  ClassMatchApp.swift
//  ClassMatch
//
//  Created by Megan Shah on 1/28/23.
//

import SwiftUI

@main
struct ClassMatchApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
