//
//  SpellingTestView.swift
//  writezi
//
//  Created by jun hao on 17/11/21.
//

import SwiftUI
import AVKit

struct SpellingTestView: View {
    
    var spellingMode:Int;
    var spellingList:SpellingList;
    var fulltime: Int
    
    @State private var finish = false
    @State private var quit = false;
    @State private var exit = false;
    @State private var questionNo = 0
    @State var stopTime = false;
    
    @State private var pinyinList: [String: String]?

    @Binding var timeRemaining: Int
    
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                NavigationLink(destination: CheckAnswerView(spellingList: spellingList, mode: spellingMode).navigationBarHidden(true), isActive: self.$finish) { EmptyView() }
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
                                print("timer")
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
                    let utterance = AVSpeechUtterance(string: spellingList.spellingList[questionNo].word)
                    utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")

                    let synth = AVSpeechSynthesizer()
                    synth.speak(utterance)
                } label: {
                    HStack{
                        Image(systemName: "speaker.wave.3.fill")
                            .imageScale(.large)
                            .foregroundColor(Color.black)
                            .font(.system(size: 100.0))
                            .padding()
                        
                        if spellingMode == 3 {
                            if let pinyinList = pinyinList {
                                var pinYin = ""
//                                ForEach(Array(spellingList.spellingList[questionNo].word), id: \.self) { character in
//                                    pinYin.append(String(character))
//                                    pinYin.append(" ")
//                                }
//                                ForEach(Array(spellingList.spellingList[questionNo].word.enumerated()), id: \.offset) { character in
//                                    pinYin.append(String(character.element))
//                                }
//                                for character in spellingList.spellingList[questionNo].word{
//
//                                }
                                
                                let wording = spellingList.spellingList[questionNo].word
//                                let arr = wording.map { pinYin += pinyinList[String($0)] ?? "" }
                                
//                                print(arr)
                                
                                
//                                Text(pinYin)
                                
                            }
                        }
                    }
                    .padding()
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
                            self.timer.upstream.connect().cancel()
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
                            self.timer.upstream.connect().cancel()
                            exit = true
                        }
                    ), secondaryButton: .default(
                        Text("Cancel"),
                        action: {}//No Action to be done
                    )
                )
            }

            .background(Color(.systemGroupedBackground))

            .onAppear {
                let str = "{\"你好\": \"nihao\"}"
                let data = Data(str.utf8)

                do {
                    // make sure this JSON is in the format we expect
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                        pinyinList = json
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            }
        }
    }
}

struct SpellingTestView_Previews: PreviewProvider {
    static var previews: some View {
        SpellingTestView(
            spellingMode: 2,
            spellingList: SpellingList(spellingList: [SpellingWord(word: "你好")], name: "HALLO"),
            fulltime: 30, timeRemaining: .constant(30)
            
        )
    }
}
