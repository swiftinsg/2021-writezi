//
//  ContentView.swift
//  writezi
//
//  Created by Ang Jun Ray on 10/11/21.
//

import SwiftUI

struct ContentView: View {
    @State public var searchText = ""
    @ObservedObject public var spellingList = DataManager()
    @State public var newSpellingList = false
    
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
                    if((searchText == "" ? spellingList.lists:
                            spellingList.lists.filter({ list in
                        return list.name.contains(searchText)
                    })).count == 0){
                        Label("No Spelling Lists Found!", systemImage: "exclamationmark.triangle.fill").foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.5))
                    }
                    ForEach (searchText == "" ? spellingList.lists:
                                spellingList.lists.filter({ list in
                        return list.name.contains(searchText)
                    })){ list in
                        NavigationLink (destination: AttemptView(reference: spellingList, spellingListIdx: list.number)){
                            VStack(alignment: .leading) {
                                Text(list.name)
                                    .bold()
                                list.pastResult?.dateOfResult == nil ?
                                Text("Not Tested Yet") :
                                Text("Last Test: \(list.pastResult?.dateOfResult.formatted(date: .long, time: .shortened) ?? Date().formatted(date: .long, time: .shortened))")
                            }
                        }
                    }
                    .onDelete { indexset in
                        spellingList.lists.remove(atOffsets: indexset)
                        spellingList.save()
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
                NewSpellingView(reference: spellingList)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

