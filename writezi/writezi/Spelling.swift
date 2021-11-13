//
//  Spelling.swift
//  writezi
//
//  Created by Ang Jun Ray on 13/11/21.
//

import Foundation

struct SpellingListInfo{
    var lastScore: Int?
    var totalCount: Int
    var spellingList: [SpellingList]
    var name: String
    init(name: String){
        self.lastScore = nil
        self.totalCount = 0
        self.spellingList = []
        self.name = name
    }
    mutating func updateList(updatedList: [SpellingList]){
        self.spellingList = updatedList
        self.totalCount = updatedList.count
    }
}

struct SpellingList{
    var name: String
    var correct: Bool
}
