//
//  TestSpellingView.swift
//  writezi
//
//  Created by jun hao on 30/12/21.
//

import SwiftUI

struct SpellingTestView: View {
    var body: some View {
        VStack {
            Image("SpellingTestView")
                .resizable()
                .scaledToFit()
            Text("Tap for reading of word")
        }
        .padding(.bottom, 60)
    }
}

struct SpellingTestView_Previews: PreviewProvider {
    static var previews: some View {
        SpellingTestView()
    }
}
