//
//  CollectionView.swift
//  LearningApp
//
//  Created by Mateusz on 04/06/2024.
//

import SwiftUI

struct SingleCollectionView: View {
    @ObservedObject var viewModel: SingleCollectionViewModel
    
    init(viewModel: CollectionViewModel, collection: Collection) {
        self.viewModel = SingleCollectionViewModel(viewModel: viewModel, collection: collection)
    }
    
    var body: some View {
        VStack {
            
            if viewModel.FlashCards.count > 0{
                HStack{
                    let percentage = viewModel.progress * 100
                    Text("Progress:")
                        .padding(.leading)
                    Text(String(format: "%.0f%%", percentage))
                        .padding(.trailing)
                    Spacer()
                    ProgressView(value: viewModel.progress)
                        .progressViewStyle(LinearProgressViewStyle())
                        .padding()
                }
            }
           
            
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
                    LearningView(viewModel: viewModel.viewModel, collection: viewModel.collection)
                } label: {
                    Text("Start learning")
                        .buttonStyle(.plain)
                        .padding()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(viewModel.backgroundColor).opacity(0.5)
                        )
                        .padding([.horizontal, .bottom])
                }
            }
        }
        .navigationTitle("\(viewModel.collection.name ?? "Unnamed") - Collection")
        .sheet(isPresented: $viewModel.editorVisible, content: {
            CreateEditCollectionView(viewModel: viewModel.viewModel, editHolder: viewModel)
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
