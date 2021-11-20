//
//  Spelling.swift
//  writezi
//
//  Created by Ang Jun Ray on 13/11/21.
//

import Foundation
import SwiftUI

struct SpellingList: Identifiable, Codable {
    var lastEdited: Date = Date()
    var created: Date = Date()
    var spellingList = [SpellingWord]()
    var name: String
    var pastResult: Result? = nil
    var id = UUID()
    var number = 0
}

struct SpellingWord: Identifiable, Codable{
    var word:String = ""
    var id = UUID()
}

struct Result: Codable {
    var score: Int
    var results: [WordResult]
    var dateOfResult = Date()
    var spellingMode: Int
    var Image: SomeImage? = nil
}

struct WordResult: Codable, Identifiable{
    var word: String
    var correct: Bool
    var number: Int = 0
    var id = UUID()
}

public struct SomeImage: Codable {
    public let photo: Data
    public init(photo: UIImage) {
        self.photo = photo.pngData()!
    }
}
