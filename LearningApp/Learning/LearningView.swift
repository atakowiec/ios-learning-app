//
//  LearningView.swift
//  LearningApp
//
//  Created by student on 07/06/2024.
//

import SwiftUI
import Foundation

struct LearningView: View {
    @ObservedObject var viewModel: LearningViewModel
    @State var offset = CGSize.zero
    
    init(viewModel: CollectionViewModel, collection: Collection) {
        self.viewModel = LearningViewModel(viewModel: viewModel, collection: collection)
        
        self.viewModel.nextFlashcard()
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                if offset.width < 0 {
                    Text("Still learning")
                        .padding()
                        .foregroundStyle(getColor())
                        .font(.system(size: min(abs(offset.width) / 200 * 30, 60)))
                        .bold()
                        .multilineTextAlignment(.trailing)
                        .frame(width: 400, alignment: Alignment.trailing)
                }
                if offset.width > 0 {
                    Text("Learned")
                        .padding()
                        .foregroundStyle(getColor())
                        .font(.system(size: min(abs(offset.width) / 200 * 30, 60)))
                        .bold()
                        .multilineTextAlignment(.leading)
                        .frame(width: 400, alignment: Alignment.leading)
                }
            }
            VStack {
                if viewModel.currentFlashcard != nil {
                    VStack {
                        Spacer()
                        Text(viewModel.currentFlashcard!.question ?? "No question")
                            .frame(width: 350, height: 200)
                            .background(grayColor)
                            .cornerRadius(10)
                            .padding()
                            .onTapGesture {
                                viewModel.onQuestionClick()
                            }
                            .zIndex(1)
                            if viewModel.allAnswers.count == 1 {
                                HStack {
                                    Text("Click to \(viewModel.answerOffset == 0 ? "hide" : "show") answer")
                                        .foregroundStyle(.gray)
                                }
                                .offset(y: -50)
                                .zIndex(2)
                            }
                        Spacer()
                        
                        ForEach(viewModel.allAnswers, id: \.self) { answer in
                            Text(answer.content!)
                                .frame(width: 350, height: 50)
                                .background(getAnswerColor(answer))
                                .cornerRadius(10)
                                .onTapGesture {
                                    viewModel.onAnswerClick(answer)
                                }
                                .offset(y: viewModel.answerOffset)
                                .zIndex(0)
                        }
                        Spacer()
                        HStack {
                            Text("Swipe right or left")
                                .foregroundStyle(.gray)
                        }
                    }
                    .background(getColor())
                    .cornerRadius(10)
                    .offset(x: offset.width, y: offset.height)
                    .gesture(DragGesture()
                        .onChanged {
                            gesture in
                            
                            self.offset = gesture.translation
                        }
                        .onEnded { _ in
                            withAnimation {
                                if abs(self.offset.width) < 200 {
                                    self.offset = .zero
                                } else {
                                    self.offset.width *= 2
                                }
                            } completion: {
                                if offset.width > 200 {
                                    viewModel.onSwipe(true)
                                }
                                if offset.width < -200 {
                                    viewModel.onSwipe(false)
                                }
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
                    .background(grayColor)
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
            return grayColor
        }
        
        if answer == viewModel.correctAnswer {
            return .blue.opacity(0.6)
        }
        
        if answer == viewModel.selectedAnswer {
            return .red.opacity(0.6)
        }
        
        return grayColor
    }
}
