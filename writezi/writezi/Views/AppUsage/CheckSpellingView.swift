//
//  CheckSpellingView.swift
//  writezi
//
//  Created by jun hao on 30/12/21.
//

import SwiftUI

struct CheckSpellingView: View {
    
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
