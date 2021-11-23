//
//  PastSpellingView.swift
//  writezi
//
//  Created by jun hao on 17/11/21.
//

import SwiftUI

struct PastSpellingResultView: View {
    
    @Binding var spellingList: SpellingList
    
    var body: some View {
        NavigationView{
            VStack{
                if spellingList.pastResult == nil{
                    Text("No previous attempt for this spelling found.")
                        .foregroundColor(.gray)
                        .background(.white)
                } else {
                    Spacer()
                    CircularProgressView(fullscore: CGFloat(spellingList.pastResult?.results.count ?? 0), score: CGFloat(spellingList.pastResult?.score ?? 0))
                        .frame(width: 200, height: 200)
                        .padding()
                    List{
                        Section(header: Text("Details")) {
                            Text("Attempt Date: \(spellingList.pastResult!.dateOfResult)").font(.system(size: 15))
                            Text("Attempt Mode: \(spellingList.pastResult!.spellingMode == .timed ? "Timed Practice" : spellingList.pastResult!.spellingMode == .normal ? "Normal Practice" : "Hinted Practice")").font(.system(size: 15))
                        }
                        Section(header: Text("Words")) {
                            ForEach (spellingList.pastResult!.results){ result in
                                NavigationLink (destination: WordMeaningView(word: result.word)){
                                    VStack(alignment: .leading) {
                                        HStack{
                                            Image(systemName: result.correct ? "checkmark.circle.fill" : "xmark.circle.fill")
                                                .foregroundColor(result.correct ? .green : .red)
                                            Text(result.word)
                                        }
                                    }
                                }
                            }
                        }
                        Section(header: Text("Archived Image")) {
                            if(spellingList.pastResult!.image != nil && spellingList.pastResult!.image?.photo != nil){
                                Image(uiImage: UIImage(data: spellingList.pastResult!.image!.photo)!)
                                    .resizable()
                                    .scaledToFit()
                                    .padding([.top, .bottom])
                            } else {
                                Text("No Image of the test was provided!").font(.subheadline)
                            }
                        }
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Previous Attempt")
        }
        
    }
}

struct PastSpellingView_Previews: PreviewProvider {
    static var previews: some View {
        PastSpellingResultView(spellingList: .constant(SpellingList(words: [SpellingWord(word: "你好")], name: "HALLO")))
    }
}
