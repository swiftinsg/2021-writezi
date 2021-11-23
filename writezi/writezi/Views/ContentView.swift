//
//  ContentView.swift
//  writezi
//
//  Created by Ang Jun Ray on 10/11/21.
//

import SwiftUI

struct ContentView: View {
    @Binding var spellingLists: [SpellingList]
    
    @State var contentViewPresented: Bool = true
    
    @State var searchText = ""
    @State var newSpellingList = false
    
    var body: some View {
        NavigationView{
            VStack {
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
                List {
                    
                    let suitableSpellingLists = spellingLists.filter { spellingList in
                        return spellingList.name.contains(searchText)
                    }
                    
                    if((searchText == "" ? spellingLists : suitableSpellingLists).count == 0) {
                        Label("No Spelling Lists Found!", systemImage: "exclamationmark.triangle.fill").foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.5))
                    }
                    
                    ForEach($spellingLists) { $spellingList in
                        // Nav Link to preview of spelling list
                        NavigationLink (destination: SpellingPreviewView(spellingList: $spellingList)){
                            VStack(alignment: .leading) {
                                Text(spellingList.name)
                                    .bold()
                                spellingList.pastResult?.dateOfResult == nil ?
                                Text("Not Tested Yet") :
                                Text("Last Test: \(spellingList.pastResult?.dateOfResult.formatted(date: .long, time: .shortened) ?? Date().formatted(date: .long, time: .shortened))")
                            }
                        }
                    }
                    .onDelete { indexset in
                        spellingLists.remove(atOffsets: indexset)
                    }
                }
                
            }
            .background(Color(.systemGroupedBackground))
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
                NewSpellingView(spellingLists: $spellingLists)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(spellingLists: .constant([SpellingList(name: "Test List")]))
    }
}

