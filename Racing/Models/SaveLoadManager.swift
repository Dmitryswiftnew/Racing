

import Foundation
import UIKit


enum Keys: String {
    case namePlayer
    case playerSetKey
    case recordsKey
    case imageKey
}


final class SaveLoadManager {
    
    private let defaults = UserDefaults.standard
    
    func saveText(_ text: String) {
        defaults.set(text, forKey: Keys.namePlayer.rawValue)
    }
    
    func loadText(for key: Keys) -> String? {
        return defaults.object(forKey: key.rawValue) as? String
    }
    
    
    func saveSettings(_ playerSettings: PlayerSettings) {
        UserDefaults.standard.set(encodable: playerSettings, forKey: Keys.playerSetKey.rawValue)
    }
    
    func loadSettings() -> PlayerSettings? {
        UserDefaults.standard.get(decodableType: PlayerSettings.self, forKey: Keys.playerSetKey.rawValue)
    }
    
    func saveRecords(_ records: [RaceRecord]) {
        UserDefaults.standard.set(encodable: records, forKey: Keys.recordsKey.rawValue)
    }
    
    func loadRecords() -> [RaceRecord] {
        UserDefaults.standard.get(decodableType: [RaceRecord].self, forKey: Keys.recordsKey.rawValue) ?? []
    }
    
    func saveImage(image: UIImage) -> String? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let filename = UUID().uuidString
        let fileURL = directory.appendingPathComponent(filename)
        guard let data = image.pngData() else { return nil }
        
        do {
            try data.write(to: fileURL)
            return filename
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func loadImage(name: String) -> UIImage? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = directory.appendingPathComponent(name)
        return UIImage(contentsOfFile:  fileURL.path)
    }
    
    func saveImageName(_ text: String) {
        defaults.set(text, forKey: Keys.imageKey.rawValue)
    }
    
    func loadImageName() -> String? {
        defaults.object(forKey: Keys.imageKey.rawValue) as? String
    }
    
    
}
