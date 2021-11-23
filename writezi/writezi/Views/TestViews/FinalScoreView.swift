//
//  FinalScoreView.swift
//  writezi
//
//  Created by James Ryan Chen on 23/11/21.
//

import SwiftUI

struct FinalScoreView: View {
    @Binding var spellingList: SpellingList
    @Binding var results: Result
    
    @State var showImagePicker = false
    @State var inputImage: UIImage?
    @State var image: Image?
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                CircularProgressView(fullscore: CGFloat(results.results.count), score: CGFloat(results.score))
                    .padding()
                    .frame(width: UIScreen.main.bounds.size.width * 0.7)
                
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
                
                
                List($results.results) { $wordResult in
                    HStack {
                        Button {
                            wordResult.correct = true
                        } label: {
                            Image(systemName: wordResult.correct ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(.green)
                        }.buttonStyle(BorderlessButtonStyle())
                        Text("\(wordResult.word)")
                        Spacer()
                        Button {
                            wordResult.correct = false
                        } label: {
                            Image(systemName: !wordResult.correct ? "xmark.circle.fill" : "circle")
                                .foregroundColor(.red)
                        }.buttonStyle(BorderlessButtonStyle())
                    }.listRowBackground(Color(.white))
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Results")
            .sheet (isPresented: $showImagePicker, onDismiss: loadImage){
                ImagePicker(image: $inputImage)
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button {
                        if inputImage != nil {
                            results.image = SomeImage(photo: inputImage!)
                        }
                        spellingList.pastResult = results
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }
                })
            }
            
        }
    }
    
    func loadImage(){
        guard let inputImage = inputImage else {return}
        image = Image(uiImage: inputImage)
    }
    
}

struct FinalScoreView_Previews: PreviewProvider {
    static var previews: some View {
        FinalScoreView(spellingList: .constant(SpellingList(words: [SpellingWord(word: "你好")], name: "HALLO")), results: .constant(Result(dateOfResult: Date(), spellingMode: .normal, results: [], image: nil)))
    }
}
