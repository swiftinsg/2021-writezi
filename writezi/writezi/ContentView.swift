//
//  ContentView.swift
//  writezi
//
//  Created by Ang Jun Ray on 10/11/21.
//

import SwiftUI

struct ContentView: View {
    
    @State public var searchText = ""
    @State public var spellingList:[SpellingList] = [SpellingList(name: "HALLO"), SpellingList(spellingList: [SpellingWord(word: "你好")], name: "HALLO")]
    @State public var newSpellingList = false
    var count = 0
    
    var body: some View {
        NavigationView{
            VStack{
                // Search bar
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9))
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $searchText)
                    }
                    .foregroundColor(.gray)
                    .padding(13)
                }
                .frame(height: 40)
                .cornerRadius(13)
                .padding()
                
                //Spelling List
                List (spellingList){ list in
                    NavigationLink (destination: AttemptView(spellingList: list)){
                        VStack(alignment: .leading) {
                            Text(list.name)
                                .bold()
                            if list.pastResult?.dateOfResult == nil {
                                Text("No test done yet")
                            } else {
                                Text("Last test date: \(list.pastResult?.dateOfResult ?? Date())")
                            }
                        }
                    }
                }
                
            }
            // Navigation Bar Items
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {EditButton()})
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button {
                        newSpellingList = true
                    } label: {
                        Image(systemName: "plus")
                    }
                })
            }
            .navigationTitle(Text("Spelling"))
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .sheet(isPresented: $newSpellingList){
                NewSpellingView(spellingList: spellingList)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

