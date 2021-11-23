//
//  AttemptView.swift
//  writezi
//
//  Created by jun hao on 16/11/21.
//

import SwiftUI

struct SpellingPreviewView: View {
    @Binding var spellingList: SpellingList
    
    @State var spellingMode: SpellingMode = .normal
    @State var selectedTime = 30
    
    @State var startSpelling = false
    
    @State var showPreviousSpellingTest = false
    @State var showingEditView = false
    
    var body: some View {
        VStack{
            NavigationLink(destination: TestSpellingView(spellingList: $spellingList, selectedTime: selectedTime, spellingMode: spellingMode).navigationBarHidden(true), isActive: self.$startSpelling) { EmptyView() }
            
            Text("Last Updated: \(spellingList.lastEdited.formatted(date: .long, time: .shortened))")
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
            
            List {
                Section (header: Text("Words")) {
                    ForEach (spellingList.words){ list in
                        NavigationLink (destination: WordMeaningView(word: list.word)){
                            VStack(alignment: .leading) {
                                Text(list.word)
                            }
                        }
                    }
                }
                Section(header: Text("Mode")) {
                    Picker("Mode of spelling", selection: $spellingMode) {
                        Text("Timed Practice")
                            .tag(SpellingMode.timed)
                        Text("Normal Practice")
                            .tag(SpellingMode.normal)
                        Text("Hinted Practice")
                            .tag(SpellingMode.hinted)
                    }
                    if spellingMode == .timed {
                        Picker("Timer", selection: $selectedTime) {
                            Text("10 Seconds")
                                .tag(10)
                            Text("20 Seconds")
                                .tag(20)
                            Text("30 Seconds")
                                .tag(30)
                            Text("40 Seconds")
                                .tag(40)
                            Text("50 Seconds")
                                .tag(50)
                            Text("60 Seconds")
                                .tag(60)
                        }
                    }
                }
            }
            Spacer()
            Button {
                startSpelling = true
            } label: {
                Text("Start")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .frame(width: UIScreen.main.bounds.size.width * 0.8)
            .tint(.green)
            .buttonStyle(.bordered)
            .controlSize(.large)
            
            Button {
                showPreviousSpellingTest = true
            }label: {
                Text("View Previous Attempt")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .frame(width: UIScreen.main.bounds.size.width * 0.8)
            .tint(.blue)
            .padding()
            .buttonStyle(.bordered)
            .controlSize(.large)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(spellingList.name)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button {
                    //Edit
                    showingEditView = true
                } label: {
                    Text("Edit")
                }
            })
        }
        .sheet(isPresented: $showPreviousSpellingTest){
            PastSpellingResultView(spellingList: $spellingList)
        }
        .sheet(isPresented: $showingEditView){
            EditSpellingView(spellingList: $spellingList)
        }
        
    }
}

struct AttemptView_Previews: PreviewProvider {
    static var previews: some View {
        SpellingPreviewView(spellingList: .constant(SpellingList(words: [SpellingWord(word: "你好")], name: "HALLO")))
    }
}
