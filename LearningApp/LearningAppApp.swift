//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Mateusz on 28/05/2024.
//

import SwiftUI

@main
struct LearningAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(CollectionViewModel())
        }
    }
}
