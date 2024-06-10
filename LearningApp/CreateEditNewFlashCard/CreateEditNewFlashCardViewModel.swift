//
//  CreateNewFlashCardViewModel.swift
//  LearningApp
//
//  Created by student on 07/06/2024.
//

import Foundation
import CoreData
import SwiftUI
class CreateEditNewFlashCardViewModel: ObservableObject {

    @Published var addedToCollection: Collection
    @Published var question = ""
    @Published var answers: [AnswerObject] = []
    @Published var errorName = ""
    @Published var errorAnswer = ""
    @Published var validAnswer = ""
    @Published var errorAnswerValid = ""
    
    let collectionViewModel: SingleCollectionViewModel
    var flashCardToEdit: Flashcard?

    init(collectionViewModel: SingleCollectionViewModel, addedToCollection: Collection, flashCardToEdit: Flashcard? = nil) {
        self.collectionViewModel = collectionViewModel
        self.addedToCollection = addedToCollection
        self.flashCardToEdit = flashCardToEdit
        
        if let flashcard = flashCardToEdit{
            question = flashcard.question ?? ""
            validAnswer = flashcard.toCorrectAnswer?.content ?? ""
            if let otherAnswers = flashcard.toOtherAnswers?.allObjects as? [Answer]{
                answers = otherAnswers.map {AnswerObject(text: $0.content ?? "")}
            }
        }
             
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
        if let flashcard = flashCardToEdit{
            flashcard.question = question
            flashcard.toCorrectAnswer?.content = validAnswer
            let otherAnswerObjects = answers.map { answer in
                let answerObject = Answer(context: collectionViewModel.context)
                answerObject.content = answer.text
                return answerObject
            }
            flashcard.toOtherAnswers = NSSet(array: otherAnswerObjects)
        }
        else{
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
        }
    
            self.collectionViewModel.saveContext()
            self.collectionViewModel.context.refreshAllObjects()
            self.collectionViewModel.fetchFlashCards()

  
    }
    
}

