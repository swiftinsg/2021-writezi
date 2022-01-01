//
//  HomeView.swift
//  writezi
//
//  Created by jun hao on 30/12/21.
//

import SwiftUI

struct HomeView: View {
    
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
            Image("HomeView")
                .resizable()
                .scaledToFit()
            Text("Add and edit spelling lists")
        }
        .padding(.bottom, 60)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
