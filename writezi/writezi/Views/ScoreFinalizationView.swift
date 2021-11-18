//
//  ScoreFinalizationView.swift
//  writezi
//
//  Created by hao jun on 17/11/21.
//

import SwiftUI

struct ScoreFinalizationView: View {
    
    var spellingList: SpellingList
    
    @State var quit = false
    @State var exit = false
    
    var body: some View {
        NavigationLink(destination: ContentView().navigationBarHidden(true), isActive: self.$exit) { EmptyView() }
        NavigationView {
            VStack{
                CircularProgressView(fullscore: 1, score: 1) // needs to be changed later
                    .padding()
                    .frame(width: UIScreen.main.bounds.size.width * 0.7)
                Button{
                    
                } label: {
                    HStack {
                        Text("Upload a photo of your test (Optional)")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding([.top, .leading, .bottom], 3.0)
                        Image(systemName: "camera")
                            .padding([.top, .bottom, .trailing], 3.0)
                    }
                }
                .frame(width: UIScreen.main.bounds.size.width * 0.9)
                .tint(.blue)
                .buttonStyle(.bordered)
                
                List (spellingList.spellingList) {spellingList in
                    Text("\(spellingList.word)")
                        .listRowBackground(Color(red: 0.0, green: 1.0, blue: 0, opacity: 0.3))//Add a if statement here later
                }
            }
                .navigationTitle("Results")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
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
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct ScoreFinalizationView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreFinalizationView(spellingList: SpellingList(spellingList: [SpellingWord(word: "你好")], name: "HALLO"))
    }
}
