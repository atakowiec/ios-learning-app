//
//  CreateCollectionViewModel.swift
//  LearningApp
//
//  Created by Mateusz on 05/06/2024.
//

import Foundation
import CoreData
import SwiftUI

class CreateCollectionViewModel: ObservableObject {
    @ObservedObject var collectionViewModel: CollectionViewModel
    @Published var error = ""
    @Published var name = ""
    
    init(collectionViewModel: CollectionViewModel) {
        self.collectionViewModel = collectionViewModel
    }
    
    func createCollection() {
        error = ""

        guard !name.isEmpty else {
            error = "Enter collection name!"
            return
        }
        
        // check whether collection with given name already exists
        guard collectionViewModel.collections.filter({ $0.name == name }).isEmpty else {
            error = "Collection with this name already exists. Enter another name"
            return
        }
        
        let newCollection = Collection(context: collectionViewModel.context)
        newCollection.id = UUID();
        newCollection.name = name
        
        collectionViewModel.saveContext()
        collectionViewModel.addCollectionVisible = false
    }
}
