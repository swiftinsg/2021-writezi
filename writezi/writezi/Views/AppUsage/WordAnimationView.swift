//
//  WordAnimationView.swift
//  writezi
//
//  Created by jun hao on 30/12/21.
//

import SwiftUI

struct WordAnimationView: View {
    var body: some View {
        VStack {
            Image("WordAnimationView")
                .resizable()
                .scaledToFit()
            Text("Tap to play character animation")
        }
        .padding(.bottom, 60)
    }
}

struct WordAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        WordAnimationView()
    }
}
