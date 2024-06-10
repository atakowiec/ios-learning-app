//
//  ListElement.swift
//  LearningApp
//
//  Created by Lukasz on 10/06/2024.
//

import SwiftUI

struct SingleCollectionListElement: View {
    var flashcard : Flashcard
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "book.pages")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.leading, 10)
                    .padding(.trailing, -10)
                Text(flashcard.question ?? "Unnamed question")
                    .font(.system(size: 24))
                    .fontWeight(.ultraLight)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .padding(.leading)
                Spacer()
                Image(systemName: flashcard.learned ? "graduationcap.fill" : "xmark")
                    .foregroundColor(flashcard.learned ? .green : .red)
                    .padding(.trailing, 20)
                

            }

        }
    }
}

