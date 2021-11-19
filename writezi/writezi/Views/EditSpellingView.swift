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
                        spellingList.lists[listNumberToEdit].spellingList.append(SpellingWord())
                    } label : {
                        Image(systemName: "plus")
                    }
                    
                }){
                    ForEach($spellingList.lists[listNumberToEdit].spellingList) { $spellingList in
                        TextField("Word", text: $spellingList.word)
                    }
                }
            }
            .navigationTitle("New List")
            .toolbar {
                Button {
                    //validate the list
                    for i in 0..<spellingList.lists[listNumberToEdit].spellingList.count{
                        
                        //check if the word is empty
                        if(spellingList.lists[listNumberToEdit].spellingList[i].word == ""){
                            //Alert
                            alertToShow = "The \(i+1)th word is empty!"
                            alertPresented = true
                            return
                        }
                        
                        //check for chinese
                        if(!isAllChinese(string: spellingList.lists[listNumberToEdit].spellingList[i].word)){
                            //Alert
                            alertToShow = "The \(i+1)th word is not Chinese!"
                            alertPresented = true
                            return
                        }
                    }
                    
                    if (spellingList.lists[listNumberToEdit].name != ""){
                        spellingList.lists[listNumberToEdit].lastEdited = Date()
                        spellingList.save()
                        print(reference)
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

struct EditSpellingView_Previews: PreviewProvider {
    static var previews: some View {
        EditSpellingView(listNumberToEdit: 1)
    }
}
