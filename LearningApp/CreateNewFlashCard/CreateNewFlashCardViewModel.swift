//
//  CreateNewFlashCardViewModel.swift
//  LearningApp
//
//  Created by student on 07/06/2024.
//

import Foundation
import CoreData
import SwiftUI
class CreateNewFlashCardViewModel: ObservableObject {
    @ObservedObject var collectionViewModel: CollectionViewModel
    @Published var addedToCollection: Collection
    @Published var question = ""
    @Published var answers: [AnswerObject] = []
    @Published var errorName = ""
    @Published var errorAnswer = ""
    @Published var validAnswer = ""
    @Published var errorAnswerValid = ""
    init(collectionViewModel: SingleCollectionViewModel, addedToCollection: Collection) {
        self.collectionViewModel = collectionViewModel.viewModel
        self.addedToCollection = addedToCollection
             
    }
    func handleAddButtonClick(){
        errorName = ""
        errorAnswerValid = ""
        guard !question.isEmpty else {
            errorName = "Question cannot be empty"
            return
        }
        
        guard !validAnswer.isEmpty else{
            errorAnswerValid = "Valid answer cannot be empty"
            return
        }
        
        let flashcard = Flashcard(context: collectionViewModel.context)
        flashcard.question = question
        
        let correctAnswer = Answer(context: collectionViewModel.context)
        correctAnswer.content = validAnswer
        flashcard.toCorrectAnswer = correctAnswer
        
        for answerText in answers{
            let otherAnswer = Answer(context: collectionViewModel.context)
            otherAnswer.content = answerText.text
            flashcard.addToToOtherAnswers(otherAnswer)
        }
        addedToCollection.addToToFlashcards(flashcard)
        addedToCollection.id = UUID()
        collectionViewModel.saveContext()
        
        
        
        question = ""
        validAnswer = ""
        answers = []
        
        
    }
    
}

