//
//  Spelling.swift
//  writezi
//
//  Created by Ang Jun Ray on 13/11/21.
//

import Foundation
import SwiftUI

struct SpellingList :Identifiable {
    var lastEdited: Date = Date()
    var created: Date = Date()
    var spellingList = [SpellingWord]()
    var name: String
    var pastResult: Result? = nil
    var id = UUID()
}
struct SpellingWord :Identifiable{
    var word:String = ""
    var id = UUID()
}
struct Result {
    var score: Int
    var results: [String: Bool]
    var dateOfResult = Date()
    var image: Image
}
