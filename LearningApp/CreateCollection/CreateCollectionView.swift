//
//  CreateCollectionView.swift
//  LearningApp
//
//  Created by Mateusz on 04/06/2024.
//

import SwiftUI

struct CreateCollectionView: View {
    @ObservedObject var viewModel: CreateCollectionViewModel
    
    init(viewModel: CollectionViewModel) {
        self.viewModel = CreateCollectionViewModel(collectionViewModel: viewModel)
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
                Button("Create collection", action: viewModel.createCollection)
                .buttonStyle(.borderless)
                .padding(.top)
            }
            .navigationTitle("Add new collection")
        }
    }
}
