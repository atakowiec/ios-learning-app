//
//  LearningView.swift
//  LearningApp
//
//  Created by student on 07/06/2024.
//

import SwiftUI

struct LearningView: View {
    @ObservedObject var viewModel: LearningViewModel
    
    init(viewModel: CollectionViewModel, collection: Collection) {
        self.viewModel = LearningViewModel(viewModel: viewModel, collection: collection)
    }
    
    var body: some View {
        VStack {
            Text(viewModel.currentFlashcard.question ?? "No question")
                .padding()
            
            Button(viewModel.currentFlashcard.toCorrectAnswer!.content!, action: {
                
            })
            
            ForEach(viewModel.incorrectAnswers, id: \.self) { answer in
                Button(answer.content!, action: {
                    
                })
            }
        }
        .padding()
        .navigationTitle("Learning: \(viewModel.collection.name ?? "Unnamed")")
    }
}
