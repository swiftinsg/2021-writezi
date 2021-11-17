//
//  SpellingTestView.swift
//  writezi
//
//  Created by jun hao on 17/11/21.
//

import SwiftUI

struct SpellingTestView: View {
    
    var spellingMode:Int;
    var spellingList:SpellingList;
    
    @State private var finish = false
    @State private var quit = false;
    @State private var exit = false;
    @State private var questionNo = 0
    @State private var timeRemaining = 30
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            Spacer()
            NavigationLink(destination: CheckAnswerView().navigationBarHidden(true), isActive: self.$finish) { EmptyView() }
            NavigationLink(destination: ContentView().navigationBarHidden(true), isActive: self.$exit) { EmptyView() }
            if spellingMode == 1 {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 100.0, height: 100.0)
                        
                    Text("\(timeRemaining)")
                        .font(.largeTitle)
                        .cornerRadius(100.0)
                        .onReceive(timer) { time in
                            if self.timeRemaining > 0 {
                                self.timeRemaining -= 1
                            } else {
                                if questionNo == spellingList.spellingList.count - 1 {
                                    finish = true
                                } else {
                                    timeRemaining = 30
                                    questionNo += 1
                                }
                            }
                        }
                        .padding(10.0)
                }
            }
            Button{
                // Sound
            } label: {
                Image(systemName: "speaker.wave.3.fill")
                    .imageScale(.large)
                    .foregroundColor(Color.black)
                    .font(.system(size: 100.0))
                    .padding()
            }
            if spellingMode == 3 {
                Text("pinyin")
            }
            Spacer()
            HStack{
                if questionNo > 0 && spellingMode != 1{
                    Button{
                        questionNo -= 1
                    } label: {
                        Text("Back")
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .frame(width: UIScreen.main.bounds.size.width * 0.35)
                    .padding()
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .tint(.blue)
                }
                Button{
                    if questionNo == spellingList.spellingList.count - 1 {
                        finish = true
                    } else {
                        timeRemaining = 30
                        questionNo += 1
                    }
                    
                } label: {
                    if questionNo == spellingList.spellingList.count - 1 {
                        Text("Finish")
                            .frame(minWidth: 0, maxWidth: .infinity)
                    } else {
                        Text("Next")
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                }
                .tint(.green)
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

struct SpellingTestView_Previews: PreviewProvider {
    static var previews: some View {
        SpellingTestView(spellingMode: 2, spellingList: SpellingList(spellingList: [SpellingWord(word: "你好")], name: "HALLO")
        )
    }
}
