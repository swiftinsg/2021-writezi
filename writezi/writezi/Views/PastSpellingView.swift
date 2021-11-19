//
//  PastSpellingView.swift
//  writezi
//
//  Created by jun hao on 17/11/21.
//

import SwiftUI

struct PastSpellingView: View {
    
    var spellingList:SpellingList
    
    var body: some View {
        NavigationView{
            VStack{
                if spellingList.pastResult == nil{
                    Image(systemName: "externaldrive.fill.badge.xmark")
                        .font(.system(size: 50.0))
                    Text("No previous attempt for this spelling found. ")
                        .padding()
                } else {
                    CircularProgressView(fullscore: CGFloat(spellingList.pastResult?.results.count ?? 0), score: CGFloat(spellingList.pastResult?.score ?? 0))
                        .frame(width: 200, height: 200)
                        .padding()
                    List{
                        Section(header: Text("Details")) {
                            Text("Attempt Date: \(spellingList.pastResult!.dateOfResult)").font(.system(size: 15))
                            Text("Attempt Mode: \(spellingList.pastResult!.spellingMode == 1 ? "Timed Practice" : spellingList.pastResult!.spellingMode == 2 ? "Normal Practice" : "Hinted Practice")").font(.system(size: 15))
                        }
                        Section(header: Text("Words")) {
                            ForEach (spellingList.pastResult!.results){ result in
                                NavigationLink (destination: WordMeaningView(word: result.word)){
                                    VStack(alignment: .leading) {
                                        Text(result.word)
                                            .listRowBackground(Color(red: !result.correct ? 1.0 : 0.0, green: result.correct ? 1.0 : 0.0, blue: 0, opacity: 0.3))
                                    }
                                }
                            }
                        }
                        Section(header: Text("Archived Image")) {
                            if(spellingList.pastResult!.Image != nil && spellingList.pastResult!.Image?.photo != nil){
                                Image(uiImage: UIImage(data: spellingList.pastResult!.Image!.photo)!)
                            } else {
                                Text("No Image of the test was provided!").font(.subheadline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Previous Attempt")
        }
    }
}

struct PastSpellingView_Previews: PreviewProvider {
    static var previews: some View {
        PastSpellingView(spellingList: SpellingList(spellingList: [SpellingWord(word: "你好")], name: "HALLO"))
    }
}
