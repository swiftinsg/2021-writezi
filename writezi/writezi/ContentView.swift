//
//  ContentView.swift
//  writezi
//
//  Created by Ang Jun Ray on 10/11/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("Hello")
                
            }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading, content: {EditButton()})
                    ToolbarItem(placement: .navigationBarTrailing, content: {Button {
                        //TODO: Setup plus button
                    } label: {
                        Text("+")
                    }
                    })
                }
                .navigationTitle(Text("Spelling"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

