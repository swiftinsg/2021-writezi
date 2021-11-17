//
//  WordMeaningView.swift
//  writezi
//
//  Created by jun hao on 16/11/21.
//

import SwiftUI

struct WordMeaningView: View {
    
    var word:String
    
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .background(Color(.systemGroupedBackground))
    }
}

struct WordMeaningView_Previews: PreviewProvider {
    static var previews: some View {
        WordMeaningView(word:"hello")
    }
}
