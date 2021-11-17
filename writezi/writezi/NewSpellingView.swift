//
//  NewSpellingView.swift
//  writezi
//
//  Created by jun hao on 16/11/21.
//

import SwiftUI
import NaturalLanguage

struct LanguageDetails{
    var confidence: [String: Double]
    var detectedLanguage: String?
}

func detectedLanguage(for string: String) -> LanguageDetails? {
    let languageRecognizer = NLLanguageRecognizer()
    languageRecognizer.processString(string)
    guard let languageCode = languageRecognizer.dominantLanguage?.rawValue else { return nil }
    let detectedLanguage = Locale.current.localizedString(forIdentifier: languageCode)
    let confidence = languageRecognizer.languageHypotheses(withMaximum: 100)
    var newConfidence = [String: Double]()
    for i in confidence{
        newConfidence[Locale.current.localizedString(forIdentifier: i.key.rawValue)!] = i.value
    }
    return LanguageDetails(confidence: newConfidence, detectedLanguage: detectedLanguage)
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
                        
                        //check if the word is empty
                        if(newSpellingList.spellingList[i].word == ""){
                            //Alert
                            alertToShow = "The \(i+1)th word is empty!"
                            alertPresented = true
                            return
                        }
                        
                        let detectedLang = detectedLanguage(for: newSpellingList.spellingList[i].word)
                        //check if natural language can find out whats the lang
                        
                        if(detectedLang == nil){
                            alertToShow = "The \(i+1)th word's language cannot be detected!"
                            alertPresented = true
                            return
                        }
                        
                        //check the language itself of each word
                        if(detectedLang!.detectedLanguage! != "Chinese, Traditional" && detectedLang!.detectedLanguage! != "Chinese, Simplified"){
                            alertToShow = "The \(i+1)th word is not Chinese, its in the \(detectedLang!.detectedLanguage!)) language!"
                            alertPresented = true
                            return
                        }
                        
                        //check the confidence of detection
                        if(detectedLang?.confidence["Chinese, Simplified"] > 95 && detectedLang?.confidence["Chinese, Traditional"] > 95){
                            alertToShow = "The \(i+1)th word is not 100% Chinese!"
                            alertPresented = true
                            return
                        }
                    }
                    let detectedLang = detectedLanguage(for: newSpellingList.name)
                    if(detectedLang!.detectedLanguage! != "Chinese, Traditional" && detectedLang!.detectedLanguage! != "Chinese, Simplified" && detectedLang!.detectedLanguage! != "English"){
                        alertToShow = "The title is not Chinese or English, its in the \(detectedLang!.detectedLanguage!)) language!"
                        alertPresented = true
                        return
                    }
                    if (newSpellingList.name != ""){
                        spellingList.append(newSpellingList)
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        //Alert
                        alertToShow = "Spelling List Title Cannot Be Empty!"
                        alertPresented = true
                    }
                    
                    //check the confidence of detection
                    if(detectedLang?.confidence["Chinese, Simplified"]? > 95 && detectedLang?.confidence["Chinese, Traditional"] > 95 && detectedLang?.confidence["English"] > 95){
                        alertToShow = "The title is not 100% Chinese!"
                        alertPresented = true
                        return
                    }
                    
                } label: {
                    Text("Save")
                }
                .alert(Text(alertToShow), isPresented: $alertPresented){
                    Button("Ok"){alertPresented = false}
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
