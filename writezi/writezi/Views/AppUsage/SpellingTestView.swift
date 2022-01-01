//
//  TestSpellingView.swift
//  writezi
//
//  Created by jun hao on 30/12/21.
//

import SwiftUI

struct SpellingTestView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
//            HStack{
//                Spacer()
//                Button{
//                    presentationMode.wrappedValue.dismiss()
//                } label: {
//                    Text("Cancel")
//                }
//                .padding(.trailing)
//            }
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
