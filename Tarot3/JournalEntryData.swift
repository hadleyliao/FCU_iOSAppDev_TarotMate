import Foundation
import SwiftData

@Model
final class JournalEntryData {
    var id: UUID
    var date: Date
    var spreadType: String
    @Relationship(deleteRule: .cascade) var cards: [TarotCardData]
    var interpretation: String
    
    init(id: UUID = UUID(), date: Date, spreadType: String, cards: [TarotCardData], interpretation: String) {
        self.id = id
        self.date = date
        self.spreadType = spreadType
        self.cards = cards
        self.interpretation = interpretation
    }
}
