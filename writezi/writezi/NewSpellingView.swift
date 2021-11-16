//
//  NewSpellingView.swift
//  writezi
//
//  Created by jun hao on 16/11/21.
//

import SwiftUI

struct NewSpellingView: View {
    @State private var newSpellingList = SpellingList(name: "")
    var body: some View {
        NavigationView{
            Form{
                Section (header: Text("Title")){
                    TextField("Title of Spelling List", text: $newSpellingList.name )
                }
            
                Section (header: HStack{
                    Text("Words")
                    Spacer()
                    Button{
                        newSpellingList.spellingList.append("")
                    } label : {
                        Image(systemName: "plus")
                    }
                    
                }){
                    ForEach($newSpellingList.spellingList, id: \.self) { $spellingList in
                        TextField( "Word", text: $spellingList)
                    }
                }
            }
            .navigationTitle("New Spelling List")
        }
    }
}

struct NewSpellingView_Previews: PreviewProvider {
    static var previews: some View {
        NewSpellingView()
    }
}
