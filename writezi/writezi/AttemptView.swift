//
//  AttemptView.swift
//  writezi
//
//  Created by jun hao on 16/11/21.
//

import SwiftUI

struct AttemptView: View {
    
    var spellingList: SpellingList
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AttemptView_Previews: PreviewProvider {
    static var previews: some View {
        AttemptView(spellingList: SpellingList(name: "Test"))
    }
}
