import Foundation
import SwiftUI

class LearningViewModel: ObservableObject {
    let viewModel: CollectionViewModel
    @Published var collection: Collection
    @Published var currentFlashcard: Flashcard
    @Published var notLearnedFlashcards: [Flashcard]
    @Published var incorrectAnswers: [Answer]
    @Published var correctAnswer: Answer
    
    init(viewModel: CollectionViewModel, collection: Collection) {
        self.viewModel = viewModel
        self.collection = collection
        
        guard let flashcardSet = collection.toFlashcards, let flashcards = flashcardSet.allObjects as? [Flashcard] else {
            fatalError("")
        }
        
        var notLearnedFlashcards = flashcards.map({$0}).filter({
            !$0.learned
        })
        
        let currentFlashcard = notLearnedFlashcards.remove(at: Int.random(in: 0..<notLearnedFlashcards.count))
        
        guard let answersSet = currentFlashcard.toOtherAnswers, let answers = answersSet.allObjects as? [Answer] else {
            fatalError("")
        }
        
        self.notLearnedFlashcards = notLearnedFlashcards
        self.currentFlashcard = currentFlashcard
        
        self.incorrectAnswers = answers.map({$0})
        self.correctAnswer = currentFlashcard.toCorrectAnswer!
    }
    
    func nextFlashcard() {
        self.currentFlashcard = notLearnedFlashcards.remove(at: Int.random(in: 0..<notLearnedFlashcards.count))
    }
}
