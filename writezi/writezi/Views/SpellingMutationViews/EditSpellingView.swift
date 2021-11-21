//
//  NewSpellingView.swift
//  writezi
//
//  Created by jun hao on 16/11/21.
//
import SwiftUI

struct EditSpellingView: View {
    @ObservedObject public var spellingList: DataManager = DataManager()
    var reference:DataManager?
    @State public var listNumberToEdit: Int
    @State private var alertToShow : String = ""
    @State private var alertPresented : Bool = false
    @State var suffix = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            Form{
                Section (header: Text("Title")){
                    TextField("Title of Spelling List", text: $spellingList.lists[listNumberToEdit].name )
                }
                
                Section (header: HStack{
                    Text("Words")
                    Spacer()
                    Button{
                        spellingList.lists[listNumberToEdit].words.append(SpellingWord())
                    } label : {
                        Image(systemName: "plus")
                    }
                    
                }){
                    ForEach($spellingList.lists[listNumberToEdit].words) { $spellingList in
                        TextField("Word", text: $spellingList.word)
                    }
                    .onDelete { indexset in
                        spellingList.lists[listNumberToEdit].words.remove(atOffsets: indexset)
                    }
                }
            }
            .navigationTitle("Edit List")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {EditButton()})
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if(spellingList.lists[listNumberToEdit].words.count < 1){
                            alertToShow = "At least 1 word must be present"
                            alertPresented = true
                            return
                        }
                        
                       //validate the list
                       for i in 0..<spellingList.lists[listNumberToEdit].words.count{
                           if i%10 == 0{
                               suffix = "st"
                           } else if i%10 == 1{
                               suffix = "nd"
                           } else if i%10 == 2{
                               suffix = "rd"
                           } else {
                               suffix = "th"
                           }
                           if(spellingList.lists[listNumberToEdit].words[i].word == ""){
                               //Alert
                               alertToShow = "The \(i+1)\(suffix) word is empty!"
                               alertPresented = true
                               return
                           }
                           
                           //check for chinese
                           if(!isAllChinese(string: spellingList.lists[listNumberToEdit].words[i].word)){
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
                       
                       if (spellingList.lists[listNumberToEdit].name != ""){
                           spellingList.lists[listNumberToEdit].lastEdited = Date()
                           spellingList.save()
                           reference?.load()
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
        EditSpellingView(listNumberToEdit: 1)
    }
}
