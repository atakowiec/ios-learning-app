//
//  CollectionView.swift
//  LearningApp
//
//  Created by Mateusz on 04/06/2024.
//

import SwiftUI

struct SingleCollectionView: View {
    @EnvironmentObject var collectionViewModel: CollectionViewModel
    @ObservedObject var viewModel: SingleCollectionViewModel
    
    init(viewModel: CollectionViewModel, collection: Collection) {
        self.viewModel = SingleCollectionViewModel(viewModel: viewModel, collection: collection)
    }
    
    var body: some View {
        VStack {
            if viewModel.collection.toFlashcards?.count == 0 {
                Text("This collection is empty!")
                    .padding()
                Button("Add new flashcard", action: viewModel.handleAddFlashcard)
                    .buttonStyle(.borderless)
            } else {
                List {
                    ForEach(viewModel.FlashCards, id: \.self) { flashcard in
                        NavigationLink(destination: {
                            CreateEditNewFlashCardView(viewModel: viewModel, addedToCollection: viewModel.collection, flashCardToEdit: flashcard)
                        }, label: {
                            SingleCollectionListElement(flashcard: flashcard)
                        })
                        .tag(flashcard)
                    }
                    .onDelete(perform: viewModel.deleteFlashcard)
                }.id(viewModel.refreshID)
                
                Spacer()
                NavigationLink {
                    LearningView(viewModel: collectionViewModel, collection: viewModel.collection)
                } label: {
                    Text("Start learning")
                        .buttonStyle(.plain)
                }
            }
        }
        .navigationTitle("\(viewModel.collection.name ?? "Unnamed") - Collection")
        .sheet(isPresented: $viewModel.editorVisible, content: {
            CreateEditCollectionView(viewModel: collectionViewModel, editHolder: viewModel)
        })
        .sheet(isPresented: $viewModel.isProccesingFlashCard, content: {
            CreateEditNewFlashCardView(viewModel: viewModel, addedToCollection: viewModel.collection)
        })
        .toolbar {
            ToolbarItem {
                Button(action: viewModel.onEditClick, label: {
                    Label("Edit collection", systemImage: "pencil")
                })
            }
        }
        .toolbar {
            ToolbarItem {
                Button(action: viewModel.handleAddFlashcard, label: {
                    Label("Add flashcard", systemImage: "plus")
                })
            }
        }
        .onAppear{
            viewModel.fetchFlashCards()
        }
    }
}
