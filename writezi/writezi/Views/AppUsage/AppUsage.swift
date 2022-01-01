//
//  AppUsage.swift
//  writezi
//
//  Created by jun hao on 24/12/21.
//

import SwiftUI

struct AppUsage: View {
    
    @State var closeText = 0
    @Environment(\.presentationMode) var presentationModeeee
    
    var body: some View {
        NavigationView{
            TabView (selection: $closeText){
                HomeView()
                    .tag(0)
                SpellingListView()
                    .tag(1)
                SpellingTestView()
                    .tag(2)
                CheckSpellingView()
                    .tag(3)
                WordDefinitionView()
                    .tag(4)
                WordAnimationView()
                    .tag(5)
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .navigationBarTitle("Help", displayMode: .inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing, content:{
                    Button {
                        if closeText == 5 {
                            UserDefaults.standard.set(true, forKey: "hasBeenLaunchedBefore")
                        }
                        presentationModeeee.wrappedValue.dismiss()
                        print("dismiss")
                    } label: {
                        Text((closeText == 5) ? "Finish" : "Cancel")
                    }
                })
            }
        }
        
    }
}

struct AppUsage_Previews: PreviewProvider {
    static var previews: some View {
        AppUsage()
    }
}
