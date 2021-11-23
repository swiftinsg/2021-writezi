//
//  Spelling.swift
//  writezi
//
//  Created by Ang Jun Ray on 13/11/21.
//

import Foundation
import SwiftUI

struct SpellingList: Identifiable, Codable {
    var id = UUID()
    
    var lastEdited: Date = Date()
    var created: Date = Date()
    var words = [SpellingWord]()
    var name: String
    var pastResult: Result? = nil
}

struct SpellingWord: Identifiable, Codable {
    var word: String = ""
    var id = UUID()
}

struct Result: Codable {
    let dateOfResult: Date
    let spellingMode: SpellingMode
    var results: [WordResult]
    var image: SomeImage? = nil
    var score: Int {
        return results.reduce(0) { $0 + ($1.correct ? 1 : 0) }
    }
    
    init(dateOfResult: Date, spellingMode: SpellingMode, results: [WordResult], image: SomeImage? = nil) {
        self.dateOfResult = dateOfResult
        self.spellingMode = spellingMode
        self.results = results
        self.image = image
    }
    
    enum CodingKeys: String, CodingKey {
        case dateOfResult
        case spellingMode
        case results
        case image
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dateOfResult = try values.decode(Date.self, forKey: .dateOfResult)
        spellingMode = try values.decode(SpellingMode.self, forKey: .spellingMode)
        results = try values.decode([WordResult].self, forKey: .results)
        image = try values.decodeIfPresent(SomeImage.self, forKey: .image)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dateOfResult, forKey: .dateOfResult)
        try container.encode(spellingMode, forKey: .spellingMode)
        try container.encode(results, forKey: .results)
        try container.encode(image, forKey: .image)
    }
    
}

struct WordResult: Codable, Identifiable {
    var word: String
    var correct: Bool
    var id = UUID()
}

struct SomeImage: Codable {
    let photo: Data
    init(photo: UIImage) {
        self.photo = photo.pngData()!
    }
}

enum SpellingMode: Int, Codable {
    case timed, normal, hinted
}

enum SpellingStage {
    case testing, checking, final
}
