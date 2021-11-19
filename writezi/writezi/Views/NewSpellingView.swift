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
    @State public var newSpellingList = SpellingList(spellingList: [SpellingWord()], name: "")
    @State public var spellingList = DataManager()
    @State public var reference:DataManager?
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
                    .onDelete { indexSet in
                        newSpellingList.spellingList.remove(atOffsets: indexSet)
                    }
                }
            }
            .navigationTitle("New List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: {
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
                            
                            //check for chinese
                            if(!isAllChinese(string: newSpellingList.spellingList[i].word)){
                                //Alert
                                alertToShow = "The \(i+1)th word is not Chinese!"
                                alertPresented = true
                                return
                            }
                        }
                        
                        if (newSpellingList.name != ""){
                            spellingList.lists.append(newSpellingList)
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
        NewSpellingView()
    }
}
