//
//  SingleColectionViewModel.swift
//  LearningApp
//
//  Created by Mateusz on 06/06/2024.
//

import Foundation
import SwiftUI
import CoreData

class SingleCollectionViewModel: CollectionEditHolder {
    public var context = PersistenceController.shared.container.viewContext
    public let viewModel: CollectionViewModel
    public let collection: Collection
    @Published var newFlashCard: Flashcard? = nil
    @Published var isProccesingFlashCard: Bool = false
    @Published var FlashCards: [Flashcard] = []
    @Published var refreshID = UUID()

    
    @Published var flashCardToEdit: Flashcard? = nil
    init(viewModel: CollectionViewModel, collection: Collection) {
        self.viewModel = viewModel
        self.collection = collection
        
        super.init()
        fetchFlashCards()
        
        self.editedCollection = collection
    }
    func fetchFlashCards() {
        if let cards = collection.toFlashcards?.allObjects as? [Flashcard]{
            FlashCards = cards
            refreshID = UUID()
        }
    }

    func onEditClick() {
        editedCollection = collection
        editorVisible.toggle()
    }
    
    func handleAddFlashcard() {
        isProccesingFlashCard.toggle()
    }
    func handleEditFlashcard(_ flashcard: Flashcard)
    {
        flashCardToEdit = flashcard
        isProccesingFlashCard.toggle()
    }
    
    func saveContext(){
        do{
            try context.save()
            context.refreshAllObjects()
        } catch{
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    func deleteFlashcard(offsets: IndexSet) {
        withAnimation {
            offsets.map { FlashCards[$0] }.forEach(context.delete)
            saveContext()
        }
    }
}
