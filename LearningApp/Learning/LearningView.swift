//
//  LearningView.swift
//  LearningApp
//
//  Created by student on 07/06/2024.
//

import SwiftUI

struct LearningView: View {
    @ObservedObject var viewModel: LearningViewModel
    @State var offset = CGSize.zero
    
    init(viewModel: CollectionViewModel, collection: Collection) {
        self.viewModel = LearningViewModel(viewModel: viewModel, collection: collection)
        
        self.viewModel.nextFlashcard()
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    if offset.width < 0 {
                        Spacer()
                        Text("Still learning")
                            .padding()
                            .foregroundStyle(getColor())
                            .font(.title)
                            .bold()
                    }
                    if offset.width > 0 {
                        Text("Learned")
                            .padding()
                            .foregroundStyle(getColor())
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                }
            }
            VStack {
                if viewModel.currentFlashcard != nil {
                    VStack {
                        Spacer()
                        Text(viewModel.currentFlashcard!.question ?? "No question")
                            .frame(width: 350, height: 200)
                            .background(Color(.secondarySystemBackground).opacity(0.6))
                            .cornerRadius(10)
                            .padding()
                        Spacer()
                        
                        ForEach(viewModel.allAnswers, id: \.self) { answer in
                            Text(answer.content!)
                                .frame(width: 350, height: 50)
                                .background(getAnswerColor(answer))
                                .cornerRadius(10)
                                .onTapGesture {
                                    viewModel.onAnswerClick(answer)
                                }
                        }
                        Spacer()
                        if viewModel.selectedAnswer != nil{
                            HStack {
                                Text("Swipe right or left")
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    .background(getColor())
                    .cornerRadius(10)
                    .offset(x: offset.width, y: offset.height)
                    .gesture(DragGesture()
                        .onChanged {
                            gesture in
                            if(viewModel.selectedAnswer == nil) {
                                return
                            }
                            
                            self.offset = gesture.translation
                        }
                        .onEnded { _ in
                            if offset.width > 200 {
                                viewModel.onSwipe(true)
                            }
                            if offset.width < -200 {
                                viewModel.onSwipe(false)
                            }
                            
                            withAnimation {
                                self.offset = .zero
                            }
                        }
                    )
                } else {
                    VStack {
                        Text("You have learned all flashcards in this collection")
                        Button("Mark all as not learned") {
                            viewModel.markAllAsNotLearned()
                        }
                        .buttonStyle(.borderless)
                        .padding(.top)
                    }
                    .cornerRadius(10)
                    .padding()
                    .frame(width: 350, height: 200)
                    .background(Color(.secondarySystemBackground).opacity(0.6))
                }
            }
            .padding()
            .navigationTitle("Learning: \(viewModel.collection.name ?? "Unnamed")")
        }
    }
    
    func getColor() -> Color {
        if(offset.width == 0) {
            return .white
        }
        
        if(offset.width < 0) {
            return .red.opacity(-Double(offset.width) / 200)
        }
        
        return .blue.opacity(Double(offset.width) / 200)
    }
    
    func getAnswerColor(_ answer: Answer) -> Color {
        if viewModel.selectedAnswer == nil {
            return Color(.secondarySystemBackground).opacity(0.6)
        }
        
        if answer == viewModel.correctAnswer {
            return .blue.opacity(0.6)
        }
        
        if answer == viewModel.selectedAnswer {
            return .red.opacity(0.6)
        }
        
        return Color(.secondarySystemBackground).opacity(0.6)
    }
}
