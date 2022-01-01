//
//  CheckSpellingView.swift
//  writezi
//
//  Created by jun hao on 30/12/21.
//

import SwiftUI

struct CheckSpellingView: View {
    var body: some View {
        VStack {
            Image("CheckSpellingView")
                .resizable()
                .scaledToFit()
            Text("Tap for word meaning")
        }
        .padding(.bottom, 60)
    }
}

struct CheckSpellingView_Previews: PreviewProvider {
    static var previews: some View {
        CheckSpellingView()
    }
}
