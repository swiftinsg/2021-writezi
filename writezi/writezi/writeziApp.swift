//
//  writeziApp.swift
//  writezi
//
//  Created by Ang Jun Ray on 10/11/21.
//

import SwiftUI

@main
struct writeziApp: App {
    
    @ObservedObject var spellingListData = DataManager()
    
    init() {
        // Swizzling
        UIBezierPath.mx_prepare()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(spellingLists: $spellingListData.spellingLists)
                .onAppear() {
                    spellingListData.load()
                }
        }
    }
}
