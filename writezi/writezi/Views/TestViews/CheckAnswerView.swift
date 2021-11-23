//
//  CheckAnswerView.swift
//  writezi
//
//  Created by jun hao on 17/11/21.
//

import SwiftUI

struct CheckAnswerView: View {
    @Binding var spellingList: SpellingList
    @Binding var spellingStage: SpellingStage
    @Binding var results: Result
    
    @State var quit = false
    @State var questionIndex = 0
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack{
                ZStack {
                    VStack(alignment: .center) {
                        Spacer()
                        NavigationLink (destination: WordMeaningView(word: "\(spellingList.words[questionIndex].word)")){
                            Text("\(spellingList.words[questionIndex].word)")
                                .font(.system(size: 75))
                                .bold()
                                .foregroundColor(.black)
                        }
                        Spacer()
                        HStack {
                            // Wrong button
                            Button {
                                results.results.append(WordResult(word: spellingList.words[questionIndex].word, correct: false))
                                if questionIndex != spellingList.words.count-1 {
                                    questionIndex += 1
                                } else {
                                    spellingStage = .final
                                }
                            } label: {
                                Text("Wrong")
                                    .frame(minWidth: 0, maxWidth: .infinity)
                            }
                            .tint(Color("Danger"))
                            .frame(width: UIScreen.main.bounds.size.width * 0.35)
                            .padding()
                            .buttonStyle(.bordered)
                            .controlSize(.large)
                            
                            // Correct button
                            Button {
                                results.results.append(WordResult(word: spellingList.words[questionIndex].word, correct: true))
                                if questionIndex != spellingList.words.count-1 {
                                    questionIndex += 1
                                } else {
                                    spellingStage = .final
                                }
                                
                            } label: {
                                Text("Correct")
                                    .frame(minWidth: 0, maxWidth: .infinity)
                            }
                            .tint(Color("Success"))
                            .frame(width: UIScreen.main.bounds.size.width * 0.35)
                            .padding()
                            .buttonStyle(.bordered)
                            .controlSize(.large)
                        }
                    }
                }
            }
            .navigationTitle((questionIndex != spellingList.words.count) ? "Question \(questionIndex + 1)": "")
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button {
                        quit = true
                    }label: {
                        Image(systemName: "xmark")
                    }
                })
            }
            .alert(isPresented: $quit) {
                Alert(
                    title: Text("Are you sure you want to quit?"),
                    message: Text("All your data for this spelling test will be lost. "),
                    primaryButton: .destructive(
                        Text("Quit"),
                        action: {
                            presentationMode.wrappedValue.dismiss()
                        }
                    ), secondaryButton: .default(
                        Text("Cancel"),
                        action: {} //No Action to be done
                    )
                )
            }
            .background(Color(.systemGroupedBackground))
        }
    }
    
}

struct CheckAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        CheckAnswerView(spellingList: .constant(SpellingList(words: [SpellingWord(word: "你好")], name: "HALLO")), spellingStage: .constant(.checking), results: .constant(Result(dateOfResult: Date(), spellingMode: .normal, results: [], image: nil)))
    }
}
