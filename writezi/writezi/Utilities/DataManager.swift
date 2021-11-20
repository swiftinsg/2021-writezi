import Foundation
import SwiftUI

class DataManager: ObservableObject {
    @Published var lists = [SpellingList]()
    let defaultList: [SpellingList] = [SpellingList(spellingList: [SpellingWord(word: "你好")], name: "Example List")]
    
    func getArchiveURL() -> URL {
        let plistName = "SpellingList.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        for i in 0..<lists.count{
            lists[i].number = i
            for j in 0..<(lists[i].pastResult?.results.count ?? 0){
                lists[i].pastResult?.results[j].number = j
            }
        }
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedList = try? propertyListEncoder.encode(lists)
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
        lists = finalList
    }
    
    init(){
        load()
        save()
    }
}
