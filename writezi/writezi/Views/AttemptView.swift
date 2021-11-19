//
//  AttemptView.swift
//  writezi
//
//  Created by jun hao on 16/11/21.
//

import SwiftUI

struct AttemptView: View {
    @State private var chooseSpellingMode = false
    @ObservedObject public var reference: DataManager
    @State public var spellingListIdx: Int
    @State private var startSpelling = false
    @State private var spellingMode:Int = 0
    @State private var previousSpellingTest = false
    @State private var showingEditView = false
    
    var body: some View {
        VStack(){
            NavigationLink(destination: SpellingTestView(spellingMode: spellingMode, spellingList: reference.lists[spellingListIdx]).navigationBarHidden(true), isActive: self.$startSpelling) { EmptyView() }
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
            }
            Spacer()
            Button{
                chooseSpellingMode = true
            } label: {
                Text("Start")
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .frame(width: UIScreen.main.bounds.size.width * 0.8)
            .tint(.green)
            .buttonStyle(.bordered)
            .controlSize(.large)
            Button{
                previousSpellingTest = true
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
        .confirmationDialog("Choose Mode", isPresented: $chooseSpellingMode) {
            Button{
                startSpelling = true
                spellingMode = 1
            }label: {
                Text("Timed Practice")
            }
            Button{
                startSpelling = true
                spellingMode = 2
            }label: {
                Text("Normal Practice")
            }
            Button{
                startSpelling = true
                spellingMode = 3
            }label: {
                Text("Hinted Practice")
            }
        }
        .sheet(isPresented: $previousSpellingTest){
            PastSpellingView(spellingList: reference.lists[spellingListIdx])
        }
        .sheet(isPresented: $showingEditView){
            EditSpellingView(listNumberToEdit: spellingListIdx)
        }
    }
}

struct AttemptView_Previews: PreviewProvider {
    static var previews: some View {
        AttemptView(reference: DataManager(), spellingListIdx: 0)
    }
}
