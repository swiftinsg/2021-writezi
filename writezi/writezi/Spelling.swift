//
//  Spelling.swift
//  writezi
//
//  Created by Ang Jun Ray on 13/11/21.
//

import Foundation

struct SpellingList {
    var lastEdited: Date = Date()
    var created: Date = Date()
    var spellingList = [String]()
    var name: String
    var pastResult: Result? = nil
}

struct Result {
    var scoree: Int? = nil
    var results: [String: Bool]
    var dateOfResult = Date()
}
