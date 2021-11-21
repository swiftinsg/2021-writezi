//
//  WordMeaningView.swift
//  writezi
//
//  Created by jun hao on 16/11/21.
//

import Foundation
import SwiftUI

struct WordMeaningView: View {
    
    var word: String
    @State var pauseStates: [Bool]
    
    init(word: String) {
        self.word = word
        self.pauseStates = [Bool](repeating: true, count: word.count)
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer(minLength: 64)
                    ForEach(0..<word.count, id: \.self) { charIndex in
                        NavigationLink(destination: CharacterMeaningView(character: Array(word)[charIndex])) {
                            HanZiAnimationView(character: Array(word)[charIndex], paused: $pauseStates[charIndex])
                        }
                    }
                }.padding()
            }
            Spacer()
            Text(word)
                .padding(.top)
                .font(.title)
            Text(word.pinyin)
            Spacer()
            Spacer()
        }
        .background(Color(.systemGroupedBackground))
    }
}

struct WordMeaningView_Previews: PreviewProvider {
    static var previews: some View {
        WordMeaningView(word:"家琛我")
    }
}
