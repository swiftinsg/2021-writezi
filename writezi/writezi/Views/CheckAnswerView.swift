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
    @State var saving = false
    
    init(spellingList: SpellingList, mode: Int){
        self.spellingList = spellingList
        self.mode = mode
        dataManager.lists[spellingList.number].pastResult = Result(score: 0, results: [], spellingMode: mode)
        dataManager.save()
    }
    
    var body: some View {
        NavigationView {
            VStack{
                NavigationLink(destination: ContentView().navigationBarHidden(true), isActive: self.$exit) { EmptyView() }
                NavigationLink(destination: ScoreFinalizationView(spellingList: dataManager.lists[spellingList.number]).navigationBarHidden(true), isActive: self.$finish) { EmptyView() }
                ZStack {
                    if saving {
                        VStack{
                            Spacer()
                            Spinner(isAnimating: true, style: .large, color: .white)
                            Text("Saving")
                                .foregroundColor(.white)
                            Spacer()
                            
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .background(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.75))
                    }
                    VStack(alignment: .center) {
                        Spacer()
                        Text("\(spellingList.spellingList[questionNo].word)")
                            .font(.system(size: 75))
                            .bold()
                        Spacer()
                        HStack{
                            Button{
                                //Save data
                                dataManager.lists[spellingList.number].pastResult?.results.append(WordResult(word: spellingList.spellingList[questionNo].word, correct: false))
                                dataManager.save {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        finish = true
                                    }
                                }
                                if questionNo != spellingList.spellingList.count-1 {
                                    questionNo += 1
                                } else {
                                    saving = true
                                }
                            } label: {
                                Text("Wrong")
                                    .frame(minWidth: 0, maxWidth: .infinity)
                            }
                            .disabled(saving)
                            .tint(Color("Danger"))
                            .frame(width: UIScreen.main.bounds.size.width * 0.35)
                            .padding()
                            .buttonStyle(.bordered)
                            .controlSize(.large)
                            Button{
                                //Save data
                                dataManager.lists[spellingList.number].pastResult?.results.append(WordResult(word: spellingList.spellingList[questionNo].word, correct: true))
                                dataManager.lists[spellingList.number].pastResult?.score += 1
                                dataManager.save {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        finish = true
                                    }
                                }
                                if questionNo != spellingList.spellingList.count-1 {
                                    questionNo += 1
                                } else {
                                    saving = true
                                }
                                
                            } label: {
                                Text("Correct")
                                    .frame(minWidth: 0, maxWidth: .infinity)
                            }
                            .disabled(saving)
                            .tint(Color("Success"))
                            .frame(width: UIScreen.main.bounds.size.width * 0.35)
                            .padding()
                            .buttonStyle(.bordered)
                            .controlSize(.large)
                        }
                    }
                }
            }
            
            
            .navigationTitle((questionNo != spellingList.spellingList.count) ? "Question \(questionNo + 1)": "")
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
