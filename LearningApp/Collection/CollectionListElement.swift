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
        let foregoundCol = Color(hex: collection.color ?? "#000000").adjustedIfWhite()

        VStack {
            HStack {
                Text(collection.name ?? "Unnamed collection")
                    .font(.system(size: 24))
                Spacer()
                Image(systemName: "pencil.tip.crop.circle.fill")
                    .foregroundColor(foregoundCol)
            }

            HStack {
                Spacer()
                Text("\(collection.toFlashcards?.count ?? 0) flashcards")
                    .textScale(.secondary)
            }
            .foregroundColor(foregoundCol)
        }
        
    }
}
