//
//  CharacterMeaningView.swift
//  writezi
//
//  Created by James Ryan Chen on 20/11/21.
//

import SwiftUI

struct CharacterMeaningView: View {
    let character: Character
    @State var paused: Bool = true
    @State var reset: Bool = false
    
    var body: some View {
        VStack {
            HanZiAnimationView(character: character, paused: $paused, reset: $reset)
                .onTapGesture {
                    paused.toggle()
                }
            
            HStack {
                Button{
                    paused.toggle()
                } label: {
                    Image(systemName: paused ? "play" : "pause")
                        .frame(minWidth: 32, maxWidth: 32, minHeight: 32, maxHeight: 32)
                }
                .tint(paused ? .green : .red)
                .buttonStyle(.bordered)
                
                Button{
                    reset.toggle()
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .frame(minWidth: 32, maxWidth: 32, minHeight: 32, maxHeight: 32)
                }
                .tint(.red)
                .buttonStyle(.bordered)
            }
            .padding(.top)
            
            Text(String(character))
                .font(.title)
                .padding(.top)
            Text(String(character).pinyin)
            
            Text("Meaning")
                .padding(.top)
                .font(.title)
            Text(HanZiUtils.getDictionaryEntryFor(character: character)?.definition ?? "No Meaning")
            
            Spacer()
            
        }
    }
}

struct CharacterMeaningView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterMeaningView(character: "字")
    }
}
