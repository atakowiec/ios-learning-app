//
//  CreateNewFlashCardView.swift
//  LearningApp
//
//  Created by student on 07/06/2024.
//

import SwiftUI
import UniformTypeIdentifiers
struct CreateEditNewFlashCardView: View {
    @ObservedObject var viewModel: CreateEditNewFlashCardViewModel
    @State var EditMode = true
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
                Text("Enter valid Answer:")
                TextField("Valid Answer: ", text: $viewModel.validAnswer)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                  
                Text(viewModel.errorAnswerValid)
                    .foregroundStyle(.red)
                Text("Add additional wrong answers:")
                ForEach(Array($viewModel.answers.enumerated()), id: \.element.id) { index, $answer in
                HStack {
                    TextField("Answer", text: $answer.text)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    Spacer()
                    Button(action: {
                        viewModel.answers.remove(at: index)
                    }) {
                        Image(systemName: "trash")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .padding(.trailing)
                    }
                    }
                }

                HStack {
                    Spacer()
                    Text(viewModel.errorAnswer)
                        .foregroundStyle(.red)
                }
                .padding(.horizontal)

                Button(action: { viewModel.addBlankAnswer() }, label: {
                    Label("", systemImage: "plus")
                        .foregroundColor(.gray)
                })


                Button("Save", action: viewModel.handleAddButtonClick)
                .buttonStyle(.borderless)
                .padding(.top)
            }
            .navigationTitle("Adding to: \(viewModel.addedToCollection.name!)")
            .navigationBarTitleDisplayMode(.inline)

        }
    }
    func addAnswer(){
        
    }
}

