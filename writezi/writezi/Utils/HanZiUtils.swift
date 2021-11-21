//
//  ChineseUtils.swift
//  writezi
//
//  Created by James Ryan Chen on 21/11/21.
//

import Foundation

enum HanZiUtils {
    static func getCharacterLine(character: Character) -> Int? {
        if let path = Bundle.main.path(forResource: "valid-characters", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let words = try JSONDecoder().decode([String].self, from: data)
                return words.firstIndex(of: String(character))
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func getDictionaryEntryFor(character: Character) -> HanZiDictionaryEntry? {
        
        if let lineIndex = getCharacterLine(character: character) {
            let streamReader = StreamReader(path: Bundle.main.path(forResource: "dictionary", ofType: "jsonl")!)!
            
            for _ in 0..<lineIndex {
                streamReader.nextLine()
            }
            let dictionary = try! JSONDecoder().decode(HanZiDictionaryEntry.self, from: streamReader.nextLine()!.data(using: .utf8)!)
            streamReader.close()
            return dictionary
            
        } else {
            return nil
        }
    }
    
    static func getGraphicfor(characcter: Character) -> HanZiDictionaryEntry? {
        return nil
    }
}
