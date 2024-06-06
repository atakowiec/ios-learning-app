//
//  ContentView.swift
//  LearningApp
//
//  Created by Mateusz on 28/05/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var viewModel: CollectionViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.collections, id: \.self.name) { collection in
                    NavigationLink {
                        CollectionView(collection: collection)
                    } label: {
                        CollectionListElement(collection: collection)
                            .swipeActions(edge: .leading) {
                                Button {
                                    viewModel.collectionToEdit = collection
                                    viewModel.addCollectionVisible.toggle()
                                } label: {
                                    Text("Edit")
                                }
                                    .tint(.blue)
                            }
                            .tag(collection.name!)
                    }
                }
                .onDelete(perform: viewModel.deleteCollection)
            }
            .sheet(isPresented: $viewModel.addCollectionVisible) {
                CreateEditCollectionView(viewModel: viewModel)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        viewModel.collectionToEdit = nil
                        viewModel.addCollectionVisible.toggle()
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
