//
//  ListElement.swift
//  LearningApp
//
//  Created by Mateusz on 04/06/2024.
//

import SwiftUI

struct CollectionListElement: View {
    var collection: Collection
    
    var body: some View {
        VStack {
            HStack {
                Text(collection.name ?? "Unnamed collection")
                Spacer()
            }
            HStack {
                Spacer()
                Text("\(collection.toFlashcards?.count ?? 0) flashcards")
                    .textScale(.secondary)
            }
            .foregroundColor(.gray)
        }
    }
}
