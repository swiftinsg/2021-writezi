//
//  HomeView.swift
//  writezi
//
//  Created by jun hao on 30/12/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
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
