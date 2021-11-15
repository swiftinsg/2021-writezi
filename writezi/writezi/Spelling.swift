//
//  Spelling.swift
//  writezi
//
//  Created by Ang Jun Ray on 13/11/21.
//

import Foundation

struct SpellingListInfo {
    var lastScore: Int? = nil
    var totalCount = 0
    var spellingList = [SpellingList]()
    var name: String
    mutating func updateList(updatedList: [SpellingList]){
        self.spellingList = updatedList
        self.totalCount = updatedList.count
    }
}

struct SpellingList{
    var name: String
    var correct: Bool
}
