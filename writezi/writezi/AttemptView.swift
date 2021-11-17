//
//  AttemptView.swift
//  writezi
//
//  Created by jun hao on 16/11/21.
//

import SwiftUI

struct AttemptView: View {
    
    @State private var chooseSpellingMode = false
    var spellingList: SpellingList
    @State private var startSpelling = false
    @State private var spellingMode:Int = 0
    
    var body: some View {
        VStack{
            NavigationLink(destination: SpellingTestView(spellingMode: spellingMode, spellingList: spellingList).navigationBarHidden(true), isActive: self.$startSpelling) { EmptyView() }
            Text("Last Updated: \(spellingList.lastEdited.formatted(date: .long, time: .shortened))")
            List{
                Section (header: Text("Words")){
                    ForEach (spellingList.spellingList){ list in
                        NavigationLink (destination:
                                            WordMeaningView(word: list.word)                ){
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
    }
}

struct AttemptView_Previews: PreviewProvider {
    static var previews: some View {
        AttemptView(spellingList: SpellingList(name: "Test"))
    }
}
