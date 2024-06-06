//
//  CollectionViewModel.swift
//  LearningApp
//
//  Created by Mateusz on 05/06/2024.
//

import Foundation
import SwiftUI
import CoreData

class CollectionViewModel: ObservableObject {
    public var context = PersistenceController.shared.container.viewContext
    @Published var collections: [Collection] = []
    @Published var addCollectionVisible = false
    @Published var collectionToEdit: Collection? = nil
    
    init() {
        fetchCollections()
    }
    
    func fetchCollections() {
        do {
            try self.collections = context.fetch(Collection.fetchRequest())
        } catch {
            print("Failed to fetch collections")
        }
    }
    
    func saveContext() {
        do {
            try context.save()
            context.refreshAllObjects()
            fetchCollections()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deleteCollection(offsets: IndexSet) {
        withAnimation {
            offsets.map { collections[$0] }.forEach(context.delete)
            saveContext()
        }
    }
}
