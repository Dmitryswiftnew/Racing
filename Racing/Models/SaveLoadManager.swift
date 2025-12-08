

import Foundation
import UIKit


enum Keys: String {
    case namePlayer
}


final class SaveLoadManager {
    
    private let defaults = UserDefaults.standard
    
    func saveText(_ text: String) {
        defaults.set(text, forKey: Keys.namePlayer.rawValue)
    }
    
    func loadText(for key: Keys) -> String? {
        return defaults.object(forKey: key.rawValue) as? String
    }
    
}
