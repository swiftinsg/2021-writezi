//
//  SpellingListView.swift
//  writezi
//
//  Created by jun hao on 30/12/21.
//

import SwiftUI

struct SpellingListView: View {
    var body: some View {
        VStack {
            Image("SpellingListView")
                .resizable()
                .scaledToFit()
            Text("Change your spelling mode")
        }
        .padding(.bottom, 60)
    }
}

struct SpellingListView_Previews: PreviewProvider {
    static var previews: some View {
        SpellingListView()
    }
}
