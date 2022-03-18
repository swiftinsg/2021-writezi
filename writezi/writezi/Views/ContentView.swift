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
    @State var newSpellingListID = UUID()
    @State var launchHelp: Bool = !UserDefaults.standard.bool(forKey: "hasBeenLaunchedBefore")
    
    @Environment(\.colorScheme) var colourScheme: ColorScheme
    
    var body: some View {
        NavigationView{
            VStack {
                // Search bar
                ZStack {
                    Rectangle()
                        .foregroundColor(colourScheme == .light ? Color(red: 0.9, green: 0.9, blue: 0.9) : Color(red: 0.1, green: 0.1, blue: 0.1))
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
                
                let suitableSpellingLists = spellingLists.filter { spellingList in
                    return spellingList.name.contains(searchText)
                }
                
                if((searchText.isEmpty ? spellingLists : suitableSpellingLists).count == 0) {
                    Text("No Spelling Lists Found!")
                        .foregroundColor(.gray)
                        .padding(.top)
                }
                
                // List of Spelling Lists
                List {
                    ForEach($spellingLists) { $spellingList in
                        // Nav Link to preview of spelling list
                        if spellingList.name.contains(searchText) || searchText.isEmpty {
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
                    }
                    .onDelete { indexset in
                        spellingLists.remove(atOffsets: indexset)
                    }
                }
                HStack{
                    Spacer()
                    Button{
                        launchHelp = true
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: 20))
                    }
                    .padding()
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
                    .id(newSpellingListID)
                })
            }
            .navigationTitle(Text("Spelling"))
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .sheet(isPresented: $newSpellingList, onDismiss: {
                newSpellingListID = UUID()
                print("true")
            }){
                NewSpellingView(spellingLists: $spellingLists)
            }
            .sheet(isPresented: $launchHelp, onDismiss: {
                UserDefaults.standard.set(true, forKey: "hasBeenLaunchedBefore")
            }){
                AppUsage()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(spellingLists: .constant([SpellingList(name: "Test List")]), launchHelp: false)
            ContentView(spellingLists: .constant([SpellingList(name: "Test List")]), launchHelp: false)
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}

