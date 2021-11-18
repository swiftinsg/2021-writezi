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
