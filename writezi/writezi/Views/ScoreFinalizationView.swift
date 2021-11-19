//
//  ScoreFinalizationView.swift
//  writezi
//
//  Created by jun hao on 17/11/21.
//

import SwiftUI

struct ScoreFinalizationView: View {
    
    var spellingList: SpellingList
    @State var exit = false
    @State var image: Image?
    @State var showImagePicker = false
    @State var inputImage: UIImage?
    @ObservedObject var dataManager = DataManager()
    
    init(spellingList: SpellingList){
        self.spellingList = spellingList
    }
    
    var body: some View {
        NavigationLink(destination: ContentView(spellingList: dataManager).navigationBarHidden(true), isActive: self.$exit) { EmptyView() }
        NavigationView {
            VStack{
                CircularProgressView(fullscore: CGFloat(dataManager.lists[spellingList.number].spellingList.count), score: CGFloat(dataManager.lists[spellingList.number].pastResult!.score))
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
                List (dataManager.lists[spellingList.number].pastResult!.results) {spellingList in
                    Text("\(spellingList.word)")
                        .listRowBackground(Color(red: !spellingList.correct ? 1.0 : 0.0, green: spellingList.correct ? 1.0 : 0.0, blue: 0, opacity: 0.3))
                }
            }
            .sheet (isPresented: $showImagePicker, onDismiss: loadImage){
                ImagePicker(image: self.$inputImage)
            }
            .navigationTitle("Results")
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button {
                        if(inputImage != nil){
                            dataManager.lists[spellingList.number].pastResult?.Image = SomeImage(photo: inputImage!)
                            dataManager.lists[spellingList.number].pastResult?.dateOfResult = Date()
                        }
                        dataManager.save()
                        exit = true
                    }label: {
                        Text("Save")
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
}

struct ScoreFinalizationView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreFinalizationView(spellingList: SpellingList(spellingList: [SpellingWord(word: "你好")], name: "HALLO"))
    }
}
