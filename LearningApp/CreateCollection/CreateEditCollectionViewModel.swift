//
//  CreateCollectionViewModel.swift
//  LearningApp
//
//  Created by Mateusz on 05/06/2024.
//

import Foundation
import CoreData
import SwiftUI

class CreateEditCollectionViewModel: ObservableObject {
    @ObservedObject var collectionViewModel: CollectionViewModel
    @Published var error = ""
    @Published var name = ""
    
    init(collectionViewModel: CollectionViewModel) {
        self.collectionViewModel = collectionViewModel
        
        self.name = self.collectionViewModel.collectionToEdit?.name ?? ""
    }
    
    func isEditing() -> Bool {
        return self.collectionViewModel.collectionToEdit != nil;
    }
    
    func handleButtonClick() {
        error = ""

        guard !name.isEmpty else {
            error = "Enter collection name!"
            return
        }
        
        // names can't be duplicated but user can enter the same name as the name of edited collection
        if !self.isEditing() || self.collectionViewModel.collectionToEdit!.name != name {
            // check whether collection with given name already exists
            guard collectionViewModel.collections.filter({ $0.name == name }).isEmpty else {
                error = "Collection with this name already exists. Enter another name"
                return
            }
        }
        
        var newCollection = self.collectionViewModel.collectionToEdit
        if newCollection == nil {
            newCollection = Collection(context: collectionViewModel.context)
            newCollection!.id = UUID();
        }
        
        newCollection!.name = name
        
        collectionViewModel.saveContext()
        collectionViewModel.addCollectionVisible = false
    }
}
