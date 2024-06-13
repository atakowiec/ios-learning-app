//
//  ContentView.swift
//  LearningApp
//
//  Created by Mateusz on 28/05/2024.
//

import SwiftUI
import CoreData

let grayColor = Color(hex: "eeeeee")

struct ContentView: View {
    @EnvironmentObject var viewModel: CollectionViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.collections, id: \.self.id) { collection in
                    NavigationLink(
                        destination: SingleCollectionView(viewModel: viewModel, collection: collection),
                        label: {
                            CollectionListElement(collection: collection)
                                .swipeActions(edge: .leading) {
                                    Button {
                                        viewModel.editedCollection = collection
                                        viewModel.editorVisible.toggle()
                                    } label: {
                                        Text("Edit")
                                    }
                                    .tint(.blue)
                                }
                                .tag(collection.id)
                        }
                    )
                }
                .onDelete(perform: viewModel.deleteCollection)
            }
            
            .sheet(isPresented: $viewModel.editorVisible) {
                CreateEditCollectionView(viewModel: viewModel, editHolder: viewModel)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: MapView()) {
                        Label("Contact Info", systemImage: "mappin")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.editedCollection = nil
                        viewModel.editorVisible.toggle()
                    }, label: {
                        Label("Add collection", systemImage: "plus")
                    })
                }
            }
            .navigationTitle("Your collections")
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

