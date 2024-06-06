//
//  CreateCollectionView.swift
//  LearningApp
//
//  Created by Mateusz on 04/06/2024.
//

import SwiftUI

struct CreateEditCollectionView: View {
    @ObservedObject var viewModel: CreateEditCollectionViewModel
    
    init(viewModel: CollectionViewModel) {
        self.viewModel = CreateEditCollectionViewModel(collectionViewModel: viewModel)
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
            .navigationTitle(viewModel.isEditing() ? "Edit collection" : "Add new collection")
        }
    }
}
