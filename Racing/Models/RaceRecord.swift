

import Foundation


final class RaceRecord: Codable {
    let playerName: String
    let time: Int
    
    init(playerName: String, time: Int) {
        self.playerName = playerName
        self.time = time
    }
}
