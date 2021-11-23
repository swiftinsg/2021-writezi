//
//  SpellingTestView.swift
//  writezi
//
//  Created by James Ryan Chen on 22/11/21.
//

import SwiftUI

struct TestSpellingView: View {
    @Binding var spellingList: SpellingList
    @State var spellingStage: SpellingStage = .testing
    
    let selectedTime: Int
    let spellingMode: SpellingMode
    
    @State var results: Result
    
    init(spellingList: Binding<SpellingList>, selectedTime: Int, spellingMode: SpellingMode) {
        self._spellingList = spellingList
        self.selectedTime = selectedTime
        self.spellingMode = spellingMode
        
        self._results = .init(initialValue: Result(dateOfResult: Date(), spellingMode: spellingMode, results: []))
    }
    
    var body: some View {
        if(spellingStage == .testing) {
            TestSpellingWordView(spellingList: $spellingList, spellingStage: $spellingStage, spellingMode: spellingMode, selectedTime: selectedTime, timeRemaining: selectedTime)
        } else if (spellingStage == .checking) {
            CheckAnswerView(spellingList: $spellingList, spellingStage: $spellingStage, results: $results)
        } else {
            FinalScoreView(spellingList: $spellingList, results: $results)
        }
    }
}

struct TestSpellingView_Previews: PreviewProvider {
    static var previews: some View {
        TestSpellingView(spellingList: .constant(SpellingList(words: [SpellingWord(word: "你好")], name: "HALLO")), selectedTime: 30, spellingMode: .hinted)
    }
}
