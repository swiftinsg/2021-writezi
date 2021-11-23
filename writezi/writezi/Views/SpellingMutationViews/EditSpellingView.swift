//
//  NewSpellingView.swift
//  writezi
//
//  Created by jun hao on 16/11/21.
//
import SwiftUI

struct EditSpellingView: View {
    @Binding var spellingList: SpellingList
    
    @State private var alertToShow : String = ""
    @State private var alertPresented : Bool = false
    @State var suffix = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            Form{
                Section (header: Text("Title")){
                    TextField("Title of Spelling List", text: $spellingList.name)
                }
                
                Section (header: HStack{
                    Text("Words")
                    Spacer()
                    Button{
                        spellingList.words.append(SpellingWord())
                    } label : {
                        Image(systemName: "plus")
                    }
                    
                }){
                    ForEach($spellingList.words) { $word in
                        TextField("Word", text: $word.word)
                    }
                    .onDelete { indexset in
                        spellingList.words.remove(atOffsets: indexset)
                    }
                }
            }
            .navigationTitle("Edit List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {EditButton()})
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if(spellingList.words.count < 1){
                            alertToShow = "At least 1 word must be present"
                            alertPresented = true
                            return
                        }
                        
                        //validate the list
                        for i in 0..<spellingList.words.count {
                            if i%10 == 0{
                                suffix = "st"
                            } else if i%10 == 1{
                                suffix = "nd"
                            } else if i%10 == 2{
                                suffix = "rd"
                            } else {
                                suffix = "th"
                            }
                            
                            if(spellingList.words[i].word == ""){
                                //Alert
                                alertToShow = "The \(i+1)\(suffix) word is empty!"
                                alertPresented = true
                                return
                            }
                            
                            //check for chinese
                            if(!isAllChinese(string: spellingList.words[i].word)){
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
                        
                        if (spellingList.name != ""){
                            spellingList.lastEdited = Date()
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
                        Button("Ok"){alertPresented = false}
                    }
                }
            }
        }
    }
}

struct EditSpellingView_Previews: PreviewProvider {
    static var previews: some View {
        EditSpellingView(spellingList: .constant(SpellingList(words: [SpellingWord(word: "你好")], name: "HALLO")))
    }
}
