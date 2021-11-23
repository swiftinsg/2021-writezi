////
////  ScoreFinalizationView.swift
////  writezi
////
////  Created by jun hao on 17/11/21.
////
//
//import SwiftUI
//
//struct OldFinalScoreView: View {
//    @Binding var spellingList: SpellingList
//    @Binding var spellingStage: SpellingStage
//
//    @State var showImagePicker = false
//    @State var inputImage: UIImage?
//    @State var edit = false
//
//    var body: some View {
//        VStack {
//            CircularProgressView(fullscore: CGFloat(spellingList.words.count), score: CGFloat(spellingList.pastResult!.score))
//                .padding()
//                .frame(width: UIScreen.main.bounds.size.width * 0.7)
//            if edit == false {
//                Text(encouragementMessage(score:Int(spellingList.pastResult!.score/spellingList.words.count*100)))
//                    .padding()
//            }
//            if spellingList.pastResult?.image != nil {
//                Button{
//                    self.showImagePicker = true
//                } label: {
//                    spellingList.pastResult?.image
//                        .resizable()
//                        .scaledToFit()
//                        .padding()
//                }
//            } else {
//                Button {
//                    self.showImagePicker = true
//                } label: {
//                    HStack {
//                        Text("Upload a photo of your test (Optional)")
//                            .frame(minWidth: 0, maxWidth: .infinity)
//                            .padding([.top, .leading, .bottom], 3.0)
//                        Image(systemName: "camera")
//                            .padding([.top, .bottom, .trailing], 3.0)
//                    }
//                }
//                .frame(width: UIScreen.main.bounds.size.width * 0.9)
//                .tint(.blue)
//                .buttonStyle(.bordered)
//            }
//
//            List (spellingList.pastResult!.results) { list in
//                HStack {
//                    if edit {
//                        Button {
//                            if list.correct == false {
//
//                            }
//                        } label: {
//                            Image(systemName: list.correct ? "checkmark.circle.fill" : "circle")
//                                .foregroundColor(.green)
//                        }
//                        .buttonStyle(BorderlessButtonStyle())
//                    }
//                    Text("\(list.word)")
//                    Spacer()
//                    if edit {
//                        Button{
//                            if list.correct == true {
//
//                            }
//                        } label: {
//                            Image(systemName: !list.correct ? "xmark.circle.fill" : "circle")
//                                .foregroundColor(.red)
//                        }
//                        .buttonStyle(BorderlessButtonStyle())
//                    }
//                }
//                .listRowBackground(!edit ? Color(red: !list.correct ? 1.0 : 0.0, green: list.correct ? 1.0 : 0.0, blue: 0, opacity: 0.3) : Color(.white))
//            }
//        }
//        .sheet (isPresented: $showImagePicker, onDismiss: loadImage){
//            ImagePicker(image: $spellingList.pastResult?.image)
//        }
//        .navigationTitle("Results")
//        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//        .toolbar{
//            ToolbarItem(placement: .navigationBarTrailing, content: {
//                Button {
//                    if(inputImage != nil){
//                        spellingList.pastResult!.image = SomeImage(photo: inputImage!)
//                    }
//                    dataManager.lists[spellingList.number] = spellingList
//                    dataManager.save()
//                    exit = true
//                } label: {
//                    Text("Save")
//                }
//            })
//            ToolbarItem(placement: .navigationBarLeading, content: {
//                Button {
//                    if edit {
//                        edit = false
//                    } else {
//                        edit = true
//                    }
//                } label: {
//                    if edit {
//                        Text("Done")
//                    } else {
//                        Text("Edit")
//                    }
//                }
//            })
//        }
//        .background(Color(.systemGroupedBackground))
//    }
//
//    func loadImage(){
//        guard let inputImage = inputImage else {return}
//        image = Image(uiImage: inputImage)
//    }
//
//    func encouragementMessage(score: Int) -> String{
//        var messageList = [""]
//        if score == 100{
//            messageList = fullMarks
//        } else if score > 75{
//            messageList = AGrade
//        } else if score > 60{
//            messageList = BCGrade
//        } else if score > 50 {
//            messageList = DGrade
//        } else if score < 50 {
//            messageList = fail
//        }
//        return messageList[Int.random(in: 0..<messageList.count)]
//    }
//}
//
//struct ScoreFinalizationView_Previews: PreviewProvider {
//    static var previews: some View {
//        FinalScoreView(spellingList: SpellingList(words: [SpellingWord(word: "你好")], name: "HALLO"))
//    }
//}
