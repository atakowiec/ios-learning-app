//
//  CreateNewFlashCardView.swift
//  LearningApp
//
//  Created by student on 07/06/2024.
//

import SwiftUI

struct CreateEditNewFlashCardView: View {
    @ObservedObject var viewModel: CreateEditNewFlashCardViewModel
    
    init(viewModel: SingleCollectionViewModel, addedToCollection: Collection, flashCardToEdit: Flashcard? = nil) {
        self.viewModel = CreateEditNewFlashCardViewModel(collectionViewModel: viewModel, addedToCollection: addedToCollection, flashCardToEdit: flashCardToEdit)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Enter the question:")
                TextField("Question: ", text: $viewModel.question)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                Text(viewModel.errorName)
                    .foregroundStyle(.red)
                TextField("Valid Answer: ", text: $viewModel.validAnswer)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                Text(viewModel.errorAnswerValid)
                    .foregroundStyle(.red)
                
                ForEach($viewModel.answers) { $answer in
                    TextField("Answer", text: $answer.text)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        }

                HStack {
                    Spacer()
                    Text(viewModel.errorAnswer)
                        .foregroundStyle(.red)
                }
                .padding(.horizontal)

                Button(action: { viewModel.answers.append(AnswerObject(text: "")) }, label: {
                    Label("", systemImage: "plus")
                        .foregroundColor(.gray)
                })


                Button("Save", action: viewModel.handleAddButtonClick)
                .buttonStyle(.borderless)
                .padding(.top)
            }
            .navigationTitle("Adding to: \(viewModel.addedToCollection.name!)")
            .font(.headline)
        }
    }
    func addAnswer(){
        
    }
}

