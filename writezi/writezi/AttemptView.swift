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
        VStack{
            List{
                Section (header: Text("Words")){
                    ForEach (spellingList.spellingList){ list in
                        NavigationLink (destination:
                                            WordMeaningView(word: list.word)                ){
                            VStack(alignment: .leading) {
                                Text(list.word)
                            }
                        }
                    }
                }
            }
            Spacer()
            Button("Start"){
                
            }
            .tint(.green)
            .padding()
            .buttonStyle(.bordered)
            .controlSize(.large)
            .frame(width: UIScreen.main.bounds.size.width * 0.8)
            Button("View Previous Attempt"){
                
            }
            .tint(.blue)
            .padding()
            .buttonStyle(.bordered)
            .controlSize(.large)
            .frame(width: UIScreen.main.bounds.size.width * 0.8)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(spellingList.name)
    }
}

struct AttemptView_Previews: PreviewProvider {
    static var previews: some View {
        AttemptView(spellingList: SpellingList(name: "Test"))
    }
}
