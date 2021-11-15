//
//  ContentView.swift
//  writezi
//
//  Created by Ang Jun Ray on 10/11/21.
//

import SwiftUI

struct ContentView: View {
    @State public var searchText = ""
    @State public var spellingList:[SpellingListInfo] = [SpellingListInfo(name: "HALLO")]
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
            }
            // Navigation Bar Items
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading, content: {EditButton()})
                    ToolbarItem(placement: .navigationBarTrailing, content: {Button {
                        //TODO: Setup plus button
                    } label: {
                        Text("+")
                    }
                    })
                }
                .navigationTitle(Text("Spelling"))
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

