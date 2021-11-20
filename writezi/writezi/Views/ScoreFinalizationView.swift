//
//  ScoreFinalizationView.swift
//  writezi
//
//  Created by jun hao on 17/11/21.
//

import SwiftUI

struct ScoreFinalizationView: View {
    
    @State var spellingList: SpellingList
    @State var exit = false
    @State var image: Image?
    @State var showImagePicker = false
    @State var inputImage: UIImage?
    @State var edit = false
    @ObservedObject var dataManager = DataManager()
    
    var body: some View {
        NavigationLink(destination: ContentView(spellingList: dataManager).navigationBarHidden(true), isActive: self.$exit) { EmptyView() }
        NavigationView {
            VStack{
                CircularProgressView(fullscore: CGFloat(spellingList.spellingList.count), score: CGFloat(spellingList.pastResult!.score))
                    .padding()
                    .frame(width: UIScreen.main.bounds.size.width * 0.7)
                if edit == false {
                    Text(encouragementMessage(score:Int(dataManager.lists[spellingList.number].pastResult!.score/dataManager.lists[spellingList.number].spellingList.count*100)))
                        .padding()
                }
                if image != nil {
                    Button{
                        self.showImagePicker = true
                    } label: {
                        image?
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                } else {
                    Button{
                        self.showImagePicker = true
                    } label: {
                        HStack {
                            Text("Upload a photo of your test (Optional)")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding([.top, .leading, .bottom], 3.0)
                            Image(systemName: "camera")
                                .padding([.top, .bottom, .trailing], 3.0)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.size.width * 0.9)
                    .tint(.blue)
                    .buttonStyle(.bordered)
                }
                List (spellingList.pastResult!.results) { list in
                    HStack {
                        if edit {
                            Button{
                                print("correct")
                                if dataManager.lists[spellingList.number].pastResult?.results[spellingList.number].correct == false {
                                    print("updated correct")
                                    dataManager.lists[spellingList.number].pastResult?.results[spellingList.number].correct = true
                                    dataManager.lists[spellingList.number].pastResult?.score += 1
                                }
                            } label: {
                                if list.correct {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                } else {
                                    Image(systemName: "circle")
                                        .foregroundColor(.green)
                                }
                            }
                            .background(.green)
                            .buttonStyle(BorderlessButtonStyle())
                        }
                        Text("\(list.word)")
                        Spacer()
                        if edit{
                            Button{
                                print("wrong")
                                if dataManager.lists[spellingList.number].pastResult?.results[spellingList.number].correct == true {
                                    print("updated wrong")
                                    dataManager.lists[spellingList.number].pastResult?.results[spellingList.number].correct = false
                                    dataManager.lists[spellingList.number].pastResult?.score -= 1
                                }
                            } label: {
                                if list.correct == false {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                } else {
                                    Image(systemName: "circle")
                                        .foregroundColor(.red)
                                }
                            }
                            .background(.green)
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    .listRowBackground(!edit ? Color(red: !list.correct ? 1.0 : 0.0, green: list.correct ? 1.0 : 0.0, blue: 0, opacity: 0.3) : Color(.white))
                }
            }
            .sheet (isPresented: $showImagePicker, onDismiss: loadImage){
                ImagePicker(image: self.$inputImage)
            }
            .navigationTitle("Results")
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button {
                        if(inputImage != nil){
                            spellingList.pastResult?.Image = SomeImage(photo: inputImage!)
                            spellingList.pastResult?.dateOfResult = Date()
                        }
                        dataManager.lists[spellingList.number] = spellingList
                        dataManager.save()
                        exit = true
                    }label: {
                        Text("Save")
                    }
                })
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button {
                        if edit {
                            edit = false
                        } else {
                            edit = true
                        }
                    } label: {
                        if edit {
                            Text("Done")
                        } else {
                            Text("Edit")
                        }
                    }
                })
            }
            .background(Color(.systemGroupedBackground))
        }
    }
    func loadImage(){
        guard let inputImage = inputImage else {return}
        image = Image(uiImage: inputImage)
    }
    func encouragementMessage(score: Int) -> String{
        var messageList = [""]
        if score == 100{
            messageList = fullMarks
        } else if score > 75{
            messageList = AGrade
        } else if score > 65{
            messageList = BGrade
        }
        return messageList[Int.random(in: 0..<messageList.count)]
    }
}

struct ScoreFinalizationView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreFinalizationView(spellingList: SpellingList(spellingList: [SpellingWord(word: "你好")], name: "HALLO"))
    }
}
