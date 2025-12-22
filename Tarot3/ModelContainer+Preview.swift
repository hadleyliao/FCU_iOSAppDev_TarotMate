import Foundation
import SwiftData

@MainActor
extension ModelContainer {
    static func forPreview() -> ModelContainer {
        let container: ModelContainer
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        
        do {
            container = try ModelContainer(for: TarotCardData.self, JournalEntryData.self, configurations: configuration)
            
            // Populate with data
            TarotDeck.populate(context: container.mainContext)
            
            // You can also add mock journal entries here for previews that need them
            let card = TarotDeck.cards.first!
            let entry = JournalEntryData(date: Date(), spreadType: "每日牌卡", cards: [card], interpretation: "這是一段綜合解說的範例文字。")
            container.mainContext.insert(entry)
            
        } catch {
            fatalError("Failed to create container for preview: \(error.localizedDescription)")
        }
        
        return container
    }
}
