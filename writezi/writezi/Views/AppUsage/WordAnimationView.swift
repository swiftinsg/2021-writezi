//
//  WordAnimationView.swift
//  writezi
//
//  Created by jun hao on 30/12/21.
//

import SwiftUI

struct WordAnimationView: View {
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
//            HStack{
//                Spacer()
//                Button{
//                    UserDefaults.standard.set(true, forKey: "hasBeenLaunchedBefore")
//                    presentationMode.wrappedValue.dismiss()
//                } label: {
//                    Text("Finish")
//                }
//                .padding(.trailing)
//            }
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
