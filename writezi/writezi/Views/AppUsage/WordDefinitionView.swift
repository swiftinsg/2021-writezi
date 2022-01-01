//
//  WordDefinitionView.swift
//  writezi
//
//  Created by jun hao on 30/12/21.
//

import SwiftUI

struct WordDefinitionView: View {
    var body: some View {
        VStack {
            Image("WordDefinitionView")
                .resizable()
                .scaledToFit()
            Text("Tap to enter character animation page for that word")
        }
        .padding(.bottom, 60)
    }
}

struct WordDefinitionView_Previews: PreviewProvider {
    static var previews: some View {
        WordDefinitionView()
    }
}
