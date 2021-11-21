//
//  DictionaryEntry.swift
//  writezi
//
//  Created by James Ryan Chen on 21/11/21.
//

import Foundation

struct HanZiDictionaryEntry: Decodable {
    let character: String
    let definition: String
    let pinyin: [String]
    let decomposition: String
    let etymology: Etymology?
    let radical: String
    let matches: [[Int]]
}

struct Etymology: Decodable {
    let type: String?
    let phonetic: String?
    let semantic: String?
    let hint: String?
}
