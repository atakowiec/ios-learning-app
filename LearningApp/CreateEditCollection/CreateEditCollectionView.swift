//
//  CreateCollectionView.swift
//  LearningApp
//
//  Created by Mateusz on 04/06/2024.
//

import SwiftUI

struct CreateEditCollectionView: View {
    @ObservedObject var viewModel: CreateEditCollectionViewModel
    @ObservedObject var editHolder: CollectionEditHolder
    
    init(viewModel: CollectionViewModel, editHolder: CollectionEditHolder) {
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

                HStack {
                    Text("Select color:")
                    ColorPicker("", selection: $viewModel.color)
                }
                .padding(.horizontal)

                Text(viewModel.error)
                    .foregroundStyle(.red)

                Button("Save collection", action: viewModel.handleButtonClick)
                    .buttonStyle(.borderless)
                    .padding(.top)
            }
            .padding()
            .background(Color(.secondarySystemBackground).opacity(0.8))
            .cornerRadius(10)
            .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
            .navigationTitle(editHolder.isEditing() ? "Edit collection" : "Add new collection")
        }
    }
}
