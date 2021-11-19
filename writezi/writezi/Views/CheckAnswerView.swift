//
//  CheckAnswerView.swift
//  writezi
//
//  Created by jun hao on 17/11/21.
//

import SwiftUI

struct CheckAnswerView: View {
    
    var spellingList: SpellingList
    
    @State private var quit = false
    @State private var exit = false
    @State private var questionNo = 0
    @State private var finish = false
    
    var body: some View {
        NavigationView {
            VStack{
                NavigationLink(destination: ContentView().navigationBarHidden(true), isActive: self.$exit) { EmptyView() }
                NavigationLink(destination: ScoreFinalizationView(spellingList: spellingList).navigationBarHidden(true), isActive: self.$finish) { EmptyView() }
                Spacer()
                Text("\(spellingList.spellingList[questionNo].word)")
                    .font(.system(size: 75))
                
                Spacer()
                HStack{
                    Button{
                        //Save data
                        if questionNo == spellingList.spellingList.count - 1 {
                            finish = true
                        } else {
                            questionNo += 1
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
                    Button{
                        //Save data
                        if questionNo == spellingList.spellingList.count - 1 {
                            finish = true
                        } else {
                            questionNo += 1
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
            .navigationTitle("Question \(questionNo + 1)")
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
                            exit = true
                        }
                    ), secondaryButton: .default(
                        Text("Cancel"),
                        action: {}//No Action to be done
                    )
                )
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct CheckAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        CheckAnswerView(spellingList: SpellingList(spellingList: [SpellingWord(word: "你好")], name: "HALLO"))
    }
}
