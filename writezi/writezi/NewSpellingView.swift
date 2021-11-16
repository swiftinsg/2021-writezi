//
//  NewSpellingView.swift
//  writezi
//
//  Created by jun hao on 16/11/21.
//

import SwiftUI
import NaturalLanguage

func detectedLanguage(for string: String) -> String? {
    let recognizer = NLLanguageRecognizer()
    recognizer.processString(string)
    guard let languageCode = recognizer.dominantLanguage?.rawValue else { return nil }
    let detectedLanguage = Locale.current.localizedString(forIdentifier: languageCode)
    return detectedLanguage
}

struct NewSpellingView: View {
    @State public var newSpellingList = SpellingList(name: "")
    @State public var spellingList : [SpellingList]
    @State private var alertToShow : String = ""
    @State private var alertPresented : Bool = false
    @Environment(\.presentationMode) var presentationMode

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
            .navigationTitle("New List")
            .toolbar {
                Button {
                    //validate the list
                    for i in 0...newSpellingList.spellingList.count{
                        if(newSpellingList.spellingList[i] == ""){
                            //Alert
                            alertToShow = "The \(i+1)th word is empty!"
                            alertPresented = true
                        }
                        print(detectedLanguage(for: newSpellingList.spellingList[i])!)
                    }
                    
                    if (newSpellingList.name != ""){
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        //Alert
                        alertToShow = "Spelling List Title Cannot Be Empty!"
                        alertPresented = true
                    }
                } label: {
                    Text("Save")
                }
                .alert(Text(alertToShow), isPresented: $alertPresented){
                    Button("Ok"){}
                }
            }
        }
    }
}

struct NewSpellingView_Previews: PreviewProvider {
    @State private var showSheet = true
    static var previews: some View {
        NewSpellingView(spellingList: [SpellingList]())
    }
}
