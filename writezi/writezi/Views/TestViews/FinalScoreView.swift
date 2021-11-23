//
//  FinalScoreView.swift
//  writezi
//
//  Created by James Ryan Chen on 23/11/21.
//

import SwiftUI

struct FinalScoreView: View {
    @Binding var spellingList: SpellingList
    @Binding var results: Result
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                CircularProgressView(fullscore: CGFloat(results.results.count), score: CGFloat(results.score))
                    .padding()
                    .frame(width: UIScreen.main.bounds.size.width * 0.7)
                
                List($results.results) { $wordResult in
                    HStack {
                        Button {
                            wordResult.correct = true
                        } label: {
                            Image(systemName: wordResult.correct ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(.green)
                        }.buttonStyle(BorderlessButtonStyle())
                        Text("\(wordResult.word)")
                        Spacer()
                        Button {
                            wordResult.correct = false
                        } label: {
                            Image(systemName: !wordResult.correct ? "xmark.circle.fill" : "circle")
                                .foregroundColor(.red)
                        }.buttonStyle(BorderlessButtonStyle())
                    }.listRowBackground(Color(.white))
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Results")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button {
                        spellingList.pastResult = results
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }
                })
            }
            
        }
    }
}

struct FinalScoreView_Previews: PreviewProvider {
    static var previews: some View {
        FinalScoreView(spellingList: .constant(SpellingList(words: [SpellingWord(word: "你好")], name: "HALLO")), results: .constant(Result(dateOfResult: Date(), spellingMode: .normal, results: [], image: nil)))
    }
}
