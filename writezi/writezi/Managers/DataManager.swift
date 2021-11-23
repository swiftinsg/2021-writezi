import Foundation
import SwiftUI

class DataManager: ObservableObject {
    @Published var spellingLists = [SpellingList]() {
        didSet {
            save()
        }
    }
    
    init() {
        load()
    }
    
    let defaultList: [SpellingList] = [SpellingList(words: [SpellingWord(word: "你好")], name: "Example List")]
    
    func getArchiveURL() -> URL {
        let plistName = "SpellingList.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedList = try? propertyListEncoder.encode(spellingLists)
        try? encodedList?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        
        var finalList: [SpellingList]!
        
        if let retrievedListData = try? Data(contentsOf: archiveURL),
           let decodedList = try? propertyListDecoder.decode(Array<SpellingList>.self, from: retrievedListData) {
            finalList = decodedList
        } else {
            finalList = defaultList
        }
        spellingLists = finalList
    }
}
