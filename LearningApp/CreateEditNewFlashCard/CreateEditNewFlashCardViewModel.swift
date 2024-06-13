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
    @Published var showTrash = false
    @Published var backgroundColor = Color.white
    
    let collectionViewModel: SingleCollectionViewModel
    var flashCardToEdit: Flashcard?

    
    init(collectionViewModel: SingleCollectionViewModel, addedToCollection: Collection, flashCardToEdit: Flashcard? = nil) {
        self.collectionViewModel = collectionViewModel
        self.addedToCollection = addedToCollection
        self.flashCardToEdit = flashCardToEdit
        self.backgroundColor = Color(hex: addedToCollection.color ?? "#FFFFFF")
        
        if let flashcard = flashCardToEdit{
            question = flashcard.question ?? ""
            validAnswer = flashcard.toCorrectAnswer?.content ?? ""
            if let otherAnswers = flashcard.toOtherAnswers?.allObjects as? [Answer]{
                answers = otherAnswers.map {AnswerObject(text: $0.content ?? "")}
            }
        }
             
    }
    func toggleTrashImage(){
        showTrash.toggle()
    }
    func addBlankAnswer(){
        if answers.isEmpty || !answers.last!.text.isEmpty{
            answers.append(AnswerObject(text: ""))
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
        guard !self.answers.contains(where: {$0.text == validAnswer}) else{
            errorAnswerValid = "Correct answer cannot be in not valid answers!"
            return
        }
        let uniqueAnswerTexts = Set(self.answers.map {$0.text})
        guard uniqueAnswerTexts.count == self.answers.count else{
            errorAnswerValid = "Wrong answers cannot contain duplicates"
            return
        }
        if let flashcard = flashCardToEdit{
            if(flashcard.question != question){
                guard collectionViewModel.FlashCards.filter({ $0.question?.lowercased() == question.lowercased()}).isEmpty else{
                    errorName = "FlashCard with the same question already exists"
                    return
                }
            }
            flashcard.question = question
            flashcard.toCorrectAnswer?.content = validAnswer
            let otherAnswerObjects = answers.filter{!$0.text.isEmpty}.map { answer in
                let answerObject = Answer(context: collectionViewModel.context)
                answerObject.content = answer.text
                return answerObject
            }
            flashcard.toOtherAnswers = NSSet(array: otherAnswerObjects)
        }
        else{
            guard collectionViewModel.FlashCards.filter({ $0.question == question}).isEmpty else{
                errorName = "FlashCard with the same question already exists"
                return
            }
            let flashcard = Flashcard(context: collectionViewModel.context)
            flashcard.id = UUID()
            flashcard.question = question
            
            let correctAnswer = Answer(context: collectionViewModel.context)
            correctAnswer.content = validAnswer
            flashcard.toCorrectAnswer = correctAnswer
            
            for answerText in answers{
                if answerText.text.isEmpty{
                    continue
                }
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

