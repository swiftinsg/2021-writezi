//
//  CheckAnswerView.swift
//  writezi
//
//  Created by hao jun on 17/11/21.
//

import SwiftUI

struct CheckAnswerView: View {
    
    @State private var quit = false
    @State private var exit = false
    
    var body: some View {
        NavigationView {
            VStack{
                NavigationLink(destination: ContentView().navigationBarHidden(true), isActive: self.$exit) { EmptyView() }
                Spacer()
                Text("Hello")
                Spacer()
                HStack{
                    Button{
                        
                    } label: {
                        Text("Wrong")
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .tint(Color("Danger"))
                    .frame(width: UIScreen.main.bounds.size.width * 0.35)
                    .padding()
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    Button{
                        
                    } label: {
                        Text("Correct")
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .tint(Color("Success"))
                    .frame(width: UIScreen.main.bounds.size.width * 0.35)
                    .padding()
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                }
            }
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

struct CheckAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        CheckAnswerView()
    }
}
