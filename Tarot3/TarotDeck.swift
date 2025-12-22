import Foundation
import SwiftData

class TarotDeck {
    static let cards: [TarotCardData] = [
        TarotCardData(name: "愚者", imageName: "the_fool", details: "代表新的開始、天真、自發性和自由精神。"),
        TarotCardData(name: "魔術師", imageName: "the_magician", details: "代表顯化、足智多謀、力量和靈感。"),
        TarotCardData(name: "女祭司", imageName: "the_high_priestess", details: "代表直覺、神聖女性、潛意識和神秘。"),
        // ... (The other 75 cards would go here)
    ]
    
    static func populate(context: ModelContext) {
        // Check if data already exists
        let descriptor = FetchDescriptor<TarotCardData>()
        if let count = try? context.fetchCount(descriptor), count > 0 {
            return // Data is already populated
        }
        
        // Insert all cards into the context
        for card in cards {
            context.insert(card)
        }
    }
}
