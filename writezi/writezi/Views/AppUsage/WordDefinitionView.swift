//
//  WordDefinitionView.swift
//  writezi
//
//  Created by jun hao on 30/12/21.
//

import SwiftUI

struct WordDefinitionView: View {
    
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
