//
//  CheckAnswerView.swift
//  writezi
//
//  Created by jun hao on 17/11/21.
//

import SwiftUI

struct CheckAnswerView: View {
    
    var spellingList: SpellingList
    var mode: Int = 0
    
    @State private var quit = false
    @State private var exit = false
    @State private var questionNo = 0
    @State private var finish = false
    @State private var dataManager = DataManager()
    
    init(spellingList: SpellingList, mode: Int){
        self.spellingList = spellingList
        self.mode = mode
        dataManager.lists[spellingList.number].pastResult = Result(score: 0, results: [], spellingMode: mode)
        dataManager.save()
    }
    
    var body: some View {
        NavigationView {
            
            VStack{
                if questionNo != spellingList.spellingList.count{
                    NavigationLink(destination: ContentView().navigationBarHidden(true), isActive: self.$exit) { EmptyView() }
                    NavigationLink(destination: ScoreFinalizationView(spellingList: dataManager.lists[spellingList.number]).navigationBarHidden(true), isActive: self.$finish) { EmptyView() }
                    Spacer()
                    Text("\(spellingList.spellingList[questionNo].word)")
                        .font(.system(size: 75))
                } else {
                    Spacer()
                    Text("\(spellingList.spellingList[questionNo-1].word)")
                        .font(.system(size: 75))
                }
                
                Spacer()
                if questionNo == spellingList.spellingList.count {
                    VStack{
                        Button {
                            dataManager.save()
                            questionNo -= 1
                            finish = true
                        } label: {
                            Text("Finish")
                        }
                        .tint(Color("Success"))
                        .frame(width: UIScreen.main.bounds.size.width * 0.35)
                        .padding()
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                    }
                } else {
                    HStack{
                        Button{
                            //Save data
                            dataManager.lists[spellingList.number].pastResult?.results.append(WordResult(word: spellingList.spellingList[questionNo].word, correct: false))
                            dataManager.save()
                            questionNo += 1
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
                            dataManager.lists[spellingList.number].pastResult?.results.append(WordResult(word: spellingList.spellingList[questionNo].word, correct: true))
                            dataManager.lists[spellingList.number].pastResult?.score += 1
                            dataManager.save()
                            questionNo += 1
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
        CheckAnswerView(spellingList: SpellingList(spellingList: [SpellingWord(word: "你好")], name: "HALLO"), mode: 0)
    }
}
