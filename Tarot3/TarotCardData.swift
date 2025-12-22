import Foundation
import SwiftData

@Model
final class TarotCardData {
    var id: UUID
    var name: String
    var imageName: String
    var details: String
    
    init(id: UUID = UUID(), name: String, imageName: String, details: String) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.details = details
    }
}
