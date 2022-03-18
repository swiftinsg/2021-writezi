//
//  SpellingTestView.swift
//  writezi
//
//  Created by jun hao on 17/11/21.
//

import SwiftUI
import AVKit

struct TestSpellingWordView: View {
    @Binding var spellingList: SpellingList
    @Binding var spellingStage: SpellingStage
    
    let spellingMode: SpellingMode
    let selectedTime: Int
    @State var timeRemaining: Int
    
    @State var quit = false
    @State var questionNo = 0
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colourScheme: ColorScheme
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                if spellingMode == .timed {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 100.0, height: 100.0)

                        Text("\(timeRemaining)")
                            .font(.largeTitle)
                            .cornerRadius(100.0)
                            .onReceive(timer) { time in
                                if self.timeRemaining > 0 {
                                    self.timeRemaining = timeRemaining - 1
                                } else {
                                    if questionNo == spellingList.words.count - 1 {
                                        spellingStage = .checking
                                    } else {
                                        timeRemaining = selectedTime
                                        questionNo += 1
                                    }
                                }
                            }
                            .padding(10.0)
                            .foregroundColor(Color.black)
                    }
                }
                Button{
                    let utterance = AVSpeechUtterance(string: spellingList.words[questionNo].word)
                    utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")

                    let synth = AVSpeechSynthesizer()
                    synth.speak(utterance)
                } label: {
                    VStack{
                        Image(systemName: "speaker.wave.3.fill")
                            .imageScale(.large)
                            .foregroundColor(colourScheme == .light ? Color.black : Color.white)
                            .font(.system(size: 100.0))
                            .padding()

                        if spellingMode == .hinted {
                            Text(spellingList.words[questionNo].word.pinyin)
                                .foregroundColor(colourScheme == .light ? .black : .white)
                                .font(.system(size: 40, weight: .heavy))
                        }
                    }
                }
                
                VStack{
                    Image(systemName: "info.circle.fill")
                        .padding(2)
                    Text("Tap the speaker button above to hear the word(s) and write the word(s) out on a piece of paper")
                        .multilineTextAlignment(.center)
                }
                    .font(.system(size: 15))
                    .frame(width: 300)
                    .foregroundColor(colourScheme == .light ? .gray : Color(red: 0.7, green: 0.7, blue: 0.7))
                Spacer()
                HStack{
                    if questionNo > 0 && spellingMode != .timed {
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
                        if questionNo == spellingList.words.count - 1 {
                            self.timer.upstream.connect().cancel()
                            spellingStage = .checking
                        } else {
                            timeRemaining = selectedTime
                            questionNo += 1
                        }

                    } label: {
                        if questionNo == spellingList.words.count - 1 {
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

struct TestSpellingWordView_Previews: PreviewProvider {
    static var previews: some View {
        TestSpellingWordView(spellingList: .constant(SpellingList(words: [SpellingWord(word: "你好")], name: "HALLO")), spellingStage: .constant(.testing),spellingMode: .hinted, selectedTime: 30, timeRemaining: 30)
    }
}
