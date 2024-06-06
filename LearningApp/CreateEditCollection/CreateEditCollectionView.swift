//
//  CreateCollectionView.swift
//  LearningApp
//
//  Created by Mateusz on 04/06/2024.
//

import SwiftUI

struct CreateEditCollectionView: View {
    @ObservedObject var viewModel: CreateEditCollectionViewModel
    @ObservedObject var editHolder: EditHolder<Collection>
    
    init(viewModel: CollectionViewModel, editHolder: EditHolder<Collection>) {
        self.viewModel = CreateEditCollectionViewModel(collectionViewModel: viewModel, editHolder: editHolder)
        self.editHolder = editHolder;
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Enter collection name:")
                TextField("Collection name", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                Text(viewModel.error)
                    .foregroundStyle(.red)
                Button("Save collection", action: viewModel.handleButtonClick)
                .buttonStyle(.borderless)
                .padding(.top)
            }
            .navigationTitle(editHolder.isEditing() ? "Edit collection" : "Add new collection")
        }
    }
}
