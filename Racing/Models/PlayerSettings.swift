

import Foundation



final class PlayerSettings: Codable {
    
    var name: String
    var carName: String
    var objectName: String
    
    
    
    convenience init() {
        self.init(name: "Player", carName: "camaro", objectName: "bin")
    }
    
    init(name: String, carName: String, objectName: String) {
        self.name = name
        self.carName = carName
        self.objectName = objectName
    }
}

