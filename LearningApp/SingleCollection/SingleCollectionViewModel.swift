//
//  SingleColectionViewModel.swift
//  LearningApp
//
//  Created by Mateusz on 06/06/2024.
//

import Foundation

class SingleCollectionViewModel: CollectionEditHolder {
    public let viewModel: CollectionViewModel
    public let collection: Collection
    @Published var newFlashCard: Flashcard? = nil
    @Published var isAddingNewFlashCard: Bool = false
    init(viewModel: CollectionViewModel, collection: Collection) {
        self.viewModel = viewModel
        self.collection = collection
        
        super.init()
        
        self.editedCollection = collection
    }
    
    func onEditClick() {
        editedCollection = collection
        editorVisible.toggle()
    }
    
    func handleAddFlashcard() {
        isAddingNewFlashCard.toggle()
        
    }

}