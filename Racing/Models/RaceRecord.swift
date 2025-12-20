

import Foundation


final class RaceRecord: Codable {
    let playerName: String
    let time: Int
    let date: Date
    
    init(playerName: String, time: Int, date: Date) {
        self.playerName = playerName
        self.time = time
        self.date = date
    }
}
