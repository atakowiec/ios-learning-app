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
    @ObservedObject var editHolder: EditHolder<Collection>
    @Published var error = ""
    @Published var name = ""
    
    init(collectionViewModel: CollectionViewModel, editHolder: EditHolder<Collection>) {
        self.collectionViewModel = collectionViewModel
        self.editHolder = editHolder
        
        self.name = self.editHolder.editedObject?.name ?? ""
    }
    
    func isEditing() -> Bool {
        return self.editHolder.isEditing()
    }
    
    func handleButtonClick() {
        error = ""

        guard !name.isEmpty else {
            error = "Enter collection name!"
            return
        }
        
        // names can't be duplicated but user can enter the same name as the name of edited collection
        if !self.isEditing() || self.editHolder.editedObject!.name != name {
            // check whether collection with given name already exists
            guard collectionViewModel.collections.filter({ $0.name == name }).isEmpty else {
                error = "Collection with this name already exists. Enter another name"
                return
            }
        }
        
        var newCollection = self.editHolder.editedObject
        if newCollection == nil {
            newCollection = Collection(context: collectionViewModel.context)
            newCollection!.id = UUID();
        }
        
        newCollection!.name = name
        
        collectionViewModel.saveContext()
        editHolder.editorVisible = false
    }
}
