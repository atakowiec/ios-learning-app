//
//  ContentView.swift
//  LearningApp
//
//  Created by Mateusz on 28/05/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var viewModel = CollectionViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.collections) { collection in
                    NavigationLink {
                        CollectionView(collection: collection)
                    } label: {
                        CollectionListElement(collection: collection)
                    }
                }
                .onDelete(perform: viewModel.deleteCollection)
            }
            .sheet(isPresented: $viewModel.addCollectionVisible) {
                CreateCollectionView(viewModel: viewModel)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
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
