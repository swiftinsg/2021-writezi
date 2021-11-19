//
//  AttemptView.swift
//  writezi
//
//  Created by jun hao on 16/11/21.
//

import SwiftUI

struct AttemptView: View {
    @ObservedObject public var reference: DataManager
    @ObservedObject public var dataManager = DataManager()
    @State public var spellingListIdx: Int
    @State private var startSpelling = false
    @State private var spellingMode:Int = 2
    @State private var showPreviousSpellingTest = false
    @State private var showingEditView = false
    @State private var chooseTime = false
    @State private var selectedTime = 30
    
    var body: some View {
        VStack(){
            NavigationLink(destination: SpellingTestView(
                spellingMode: spellingMode,
                spellingList: reference.lists[spellingListIdx],
                
                fulltime: selectedTime, timeRemaining: $selectedTime
            ).navigationBarHidden(true), isActive: self.$startSpelling) { EmptyView() }
            Text("Last Updated: \(reference.lists[spellingListIdx].lastEdited.formatted(date: .long, time: .shortened))")
                .frame(alignment: .leading)
                .padding(10)
            List{
                Section (header: Text("Words")){
                    ForEach (reference.lists[spellingListIdx].spellingList){ list in
                        NavigationLink (destination: WordMeaningView(word: list.word)                ){
                            VStack(alignment: .leading) {
                                Text(list.word)
                            }
                        }
                    }
                }
                Section(header: Text("Mode")) {
                    Picker("Mode of spelling", selection: $spellingMode) {
                        Text("Timed Practice")
                            .tag(1)
                        Text("Normal Practice")
                            .tag(2)
                        Text("Hinted Practice")
                            .tag(3)
                    }
                    if spellingMode == 1 {
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
            Button{
                startSpelling = true
            } label: {
                Text("Start")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .frame(width: UIScreen.main.bounds.size.width * 0.8)
            .tint(.green)
            .buttonStyle(.bordered)
            .controlSize(.large)
            Button{
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
        .navigationTitle(reference.lists[spellingListIdx].name)
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
            PastSpellingView(spellingList: reference.lists[spellingListIdx])
        }
        .sheet(isPresented: $showingEditView){
            EditSpellingView(spellingList: reference, listNumberToEdit: spellingListIdx)
        }
        
    }
}

struct AttemptView_Previews: PreviewProvider {
    static var previews: some View {
        AttemptView(reference: DataManager(), spellingListIdx: 0)
    }
}
