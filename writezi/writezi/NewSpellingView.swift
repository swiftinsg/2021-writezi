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
    @State public var newSpellingList = SpellingList(spellingList: [SpellingWord()], name: "")
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
                        newSpellingList.spellingList.append(SpellingWord())
                    } label : {
                        Image(systemName: "plus")
                    }
                    
                }){
                    ForEach($newSpellingList.spellingList) { $spellingList in
                        TextField("Word", text: $spellingList.word)
                    }
                }
            }
            .navigationTitle("New List")
            .toolbar {
                Button {
                    //validate the list
                    for i in 0..<newSpellingList.spellingList.count{
                        if(newSpellingList.spellingList[i].word == ""){
                            //Alert
                            alertToShow = "The \(i+1)th word is empty!"
                            alertPresented = true
                        }
                        print(detectedLanguage(for: newSpellingList.spellingList[i].word)!)
                    }
                    
                    if (newSpellingList.name != ""){
                        spellingList.append(newSpellingList)
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
