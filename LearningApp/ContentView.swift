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
                ForEach(viewModel.collections, id: \.self.id) { collection in
                    NavigationLink (destination: {
                        SingleCollectionView(viewModel: viewModel, collection: collection)
                    }, label: {
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
                            .tag(collection.name!)
                    })
                }
                .onDelete(perform: viewModel.deleteCollection)
            }
            .sheet(isPresented: $viewModel.editorVisible) {
                CreateEditCollectionView(viewModel: viewModel, editHolder: viewModel)
            }
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: MapView()) {
                                            Label("Contact Info", systemImage: "mappin")
                                        }
                }
                ToolbarItem {
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
