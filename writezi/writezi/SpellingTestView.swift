//
//  SpellingTestView.swift
//  writezi
//
//  Created by jun hao on 17/11/21.
//

import SwiftUI

struct SpellingTestView: View {
    
    var spellingMode:Int
    @State private var quit = false
    @State private var exit = false
    
    var body: some View {
        VStack{
            Spacer()
            NavigationLink(destination: ContentView().navigationBarHidden(true), isActive: self.$exit) { EmptyView() }
            Button{
                
            } label: {
                Image(systemName: "speaker.wave.3.fill")
                    .imageScale(.large)
                    .font(.system(size: 100.0))
                .padding()
            }
            if spellingMode == 3 {
                Text("pinyin")
            }
            Spacer()
            HStack{
                Button{
                    
                } label: {
                    Text("Back")
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .frame(width: UIScreen.main.bounds.size.width * 0.35)
                .padding()
                .buttonStyle(.bordered)
                .controlSize(.large)
                .tint(.blue)
                Button{
                    
                } label: {
                    Text("Next")
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .tint(.green)
                .frame(width: UIScreen.main.bounds.size.width * 0.35)
                .padding()
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading, content: {
                Button {
                    quit = true
                }label: {
                    Image(systemName: "xmark")
                }
            })
        }
        .alert(isPresented: $quit) {
            Alert(
                title: Text("Are you sure you want to quit?"),
                message: Text("All your data for this spelling test will be lost. "),
                primaryButton: .destructive(
                    Text("Quit"),
                    action: {
                        exit = true
                    }
                ), secondaryButton: .default(
                    Text("Cancel"),
                    action: {}//No Action to be done
                )
            )
        }
    }
}

struct SpellingTestView_Previews: PreviewProvider {
    static var previews: some View {
        SpellingTestView(spellingMode: 2
        )
    }
}
