//
//  LittlelemonApp.swift
//  Littlelemon
//
//  Created by Paul on 30/12/2024.
//

import SwiftUI

@main
struct LittlelemonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Onboarding()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
