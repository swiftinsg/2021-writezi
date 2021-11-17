//
//  ScoreFinalizationView.swift
//  writezi
//
//  Created by hao jun on 17/11/21.
//

import SwiftUI

struct ScoreFinalizationView: View {
    
    var spellingList: SpellingList
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct ScoreFinalizationView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreFinalizationView(spellingList: SpellingList(spellingList: [SpellingWord(word: "你好")], name: "HALLO"))
    }
}
