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
        NavigationView {
            VStack {
                if viewModel.collection.toFlashcards?.count == 0 {
                    Text("This collection is empty!")
                        .padding()
                    Button("Add new flashcard", action: viewModel.handleAddFlashcard)
                        .buttonStyle(.borderless)
                } else {
                    
                }
            }
        }
        .navigationTitle("\(viewModel.collection.name ?? "Unnamed") - Collection")
        .sheet(isPresented: $viewModel.editorVisible, content: {
            CreateEditCollectionView(viewModel: collectionViewModel, editHolder: viewModel)
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
    }
}
