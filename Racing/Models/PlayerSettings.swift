

import Foundation



final class PlayerSettings: Codable {
    
    var name: String
    var carName: String
    var objectName: String
    var speedGame: Double
    
    
    
    convenience init() {
        self.init(name: "Player", carName: "camaro", objectName: "bin", speedGame: 5.0)
    }
    
    init(name: String, carName: String, objectName: String, speedGame: Double) {
        self.name = name
        self.carName = carName
        self.objectName = objectName
        self.speedGame = speedGame
    }
}

