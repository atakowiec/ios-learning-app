import Foundation
import SwiftUI

class LearningViewModel: ObservableObject {
    let viewModel: CollectionViewModel
    @Published var collection: Collection
    @Published var notLearnedFlashcards: [Flashcard]
    @Published var currentFlashcard: Flashcard? = nil
    @Published var allAnswers: [Answer] = []
    @Published var correctAnswer: Answer? = nil
    @Published var selectedAnswer: Answer? = nil
    @Published var cardColor = Color.gray
    
    @Published var answerOffset = CGFloat.zero
    
    init(viewModel: CollectionViewModel, collection: Collection) {
        self.viewModel = viewModel
        self.collection = collection
        self.cardColor = Color(hex: collection.color ?? "#A0A0A0")
        guard let flashcardSet = collection.toFlashcards, let flashcards = flashcardSet.allObjects as? [Flashcard] else {
            fatalError("")
        }
        
        self.notLearnedFlashcards = flashcards.filter({
            !$0.learned
        })
    }
    
    func nextFlashcard() {
        self.selectedAnswer = nil
        self.currentFlashcard = nil
        self.allAnswers = []
        self.correctAnswer = nil
        
        if notLearnedFlashcards.isEmpty {
            return
        }
        
        self.currentFlashcard = notLearnedFlashcards.remove(at: Int.random(in: 0..<notLearnedFlashcards.count))
        
        guard let answersSet = currentFlashcard!.toOtherAnswers, let answers = answersSet.allObjects as? [Answer] else {
            fatalError("")
        }
        
        
        self.allAnswers = answers + [currentFlashcard!.toCorrectAnswer!]
        self.correctAnswer = currentFlashcard!.toCorrectAnswer!
        
        if allAnswers.count == 1 {
            answerOffset = -300
        }
    }
    
    func onAnswerClick(_ answer: Answer) {
        if self.allAnswers.count == 1 {
            return
        }
        
        self.selectedAnswer = answer
    }
    
    func onSwipe(_ learned: Bool) {
        if let flashcard = currentFlashcard {
            flashcard.learned = learned

            viewModel.saveContext()
            
            if !learned {
                notLearnedFlashcards.insert(flashcard, at: notLearnedFlashcards.isEmpty ? 0 : Int.random(in: 0..<notLearnedFlashcards.count))
            }
        }
        
        nextFlashcard()
    }
    
    func markAllAsNotLearned() {
        collection.toFlashcards?.allObjects.forEach {
            ($0 as? Flashcard)!.learned = false
        }
        viewModel.saveContext()
        
        guard let flashcardSet = collection.toFlashcards, let flashcards = flashcardSet.allObjects as? [Flashcard] else {
            fatalError("")
        }
        
        self.notLearnedFlashcards = flashcards.filter({
            !$0.learned
        })
        
        nextFlashcard()
    }
    
    func onQuestionClick() {
        if allAnswers.count != 1 {
            return
        }
        
        withAnimation {
            answerOffset = answerOffset == 0 ? -300 : 0
        }
    }
}
