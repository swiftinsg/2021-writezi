//
//  NewSpellingView.swift
//  writezi
//
//  Created by jun hao on 16/11/21.
//
import SwiftUI

func isAllChinese(string: String) -> Bool{
    var result = true
    string.forEach { char in
        let regex = try! NSRegularExpression(pattern: "\\p{Han}", options: [])
        let isMatch = regex.firstMatch(in: "\(char)", options: [], range: NSMakeRange(0, char.utf16.count)) != nil
        result = result && isMatch
    }
    return result
}

struct NewSpellingView: View {
    @Binding public var spellingLists: [SpellingList]
    @State public var newSpellingList = SpellingList(words: [SpellingWord()], name: "")
    
    @State var suffix = ""
    @State private var alertToShow : String = ""
    @State private var alertPresented : Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Title")) {
                    TextField("Title of Spelling List", text: $newSpellingList.name )
                }
                
                Section(header: HStack {
                    Text("Words")
                    Spacer()
                    Button { newSpellingList.words.append(SpellingWord()) } label : { Image(systemName: "plus") }
                }){
                    ForEach($newSpellingList.words) { $spellingList in
                        TextField("Word", text: $spellingList.word)
                    }
                    .onDelete { indexSet in
                        newSpellingList.words.remove(atOffsets: indexSet)
                    }
                }
            }
            .navigationTitle("New List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button {
                        if(newSpellingList.words.count < 1){
                            alertToShow = "At least 1 word must be present"
                            alertPresented = true
                            return
                        }
                        // Validate the list
                        for i in 0..<newSpellingList.words.count{
                            
                            // Check if the word is empty
                            if(newSpellingList.words[i].word == ""){
                                //Alert
                                
                                if i%10 == 0{
                                    suffix = "st"
                                } else if i%10 == 1{
                                    suffix = "nd"
                                } else if i%10 == 2{
                                    suffix = "rd"
                                } else {
                                    suffix = "th"
                                }
                                alertToShow = "The \(i+1)\(suffix) word is empty!"
                                alertPresented = true
                                return
                            }
                            
                            // Check for chinese
                            if(!isAllChinese(string: newSpellingList.words[i].word)){
                                // Alert
                                if i%10 == 0{
                                    suffix = "st"
                                } else if i%10 == 1{
                                    suffix = "nd"
                                } else if i%10 == 2{
                                    suffix = "rd"
                                } else {
                                    suffix = "th"
                                }
                                alertToShow = "The \(i+1)\(suffix) word is not Chinese!"
                                alertPresented = true
                                return
                            }
                        }
                        
                        if (newSpellingList.name != ""){
                            spellingLists.append(newSpellingList)
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            // Alert
                            alertToShow = "Spelling List Title Cannot Be Empty!"
                            alertPresented = true
                        }
                        
                    } label: {
                        Text("Save")
                    }})
                ToolbarItem(placement: .navigationBarLeading, content: {EditButton()})
            }
            .alert(Text(alertToShow), isPresented: $alertPresented){
                Button("Ok"){alertPresented = false}
            }
        }
    }
}

struct NewSpellingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NewSpellingView(spellingLists: .constant([SpellingList(words: [SpellingWord(word: "你好")], name: "HALLO")]))
                .previewInterfaceOrientation(.portrait)
            //            NewSpellingView(spellingLists: .constant([SpellingList(words: [SpellingWord(word: "你好")], name: "HALLO")]))
            //                .previewInterfaceOrientation(.portrait)
        }
    }
}
