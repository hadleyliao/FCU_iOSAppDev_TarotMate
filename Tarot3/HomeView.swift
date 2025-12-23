import SwiftUI
import SwiftData

struct ReadingResult: Identifiable {
    let id = UUID()
    let cards: [TarotCardData]
    let spreadType: String
}

// A model for the card spread option
struct SpreadOption: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let iconName: String
    let cardCount: Int
}

struct HomeView: View {
    @Query private var cards: [TarotCardData]
    @State private var readingResult: ReadingResult?
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                VStack(spacing: 40) {
                    Image(systemName: "moon.stars.fill")
                        .font(.system(size: 180))
                        .foregroundColor(Color("PrimaryAccent"))

                    Text("心之所想，心之所向")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("PrimaryText"))

                    Text("讓塔羅牌卡引導您新的一天。")
                        .font(.body)
                        .foregroundColor(Color("SecondaryText"))
                }
                .padding(.vertical, 20)

                // Action Buttons
                VStack(alignment: .leading, spacing: 16) {
                    Text("開始占卜")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("PrimaryText"))

                    let columns = [GridItem(.flexible()), GridItem(.flexible())]

                    LazyVGrid(columns: columns, spacing: 20) {
                        Button(action: { drawCards(count: 1, spreadType: "每日牌卡", iconName: "sun.max.fill") }) {
                            VStack(spacing: 8) {
                                Image(systemName: "sun.max.fill")
                                    .font(.system(size: 32))
                                    .foregroundColor(Color("PrimaryAccent"))
                                Text("每日抽牌")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("PrimaryText"))
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                            .padding(.vertical, 10)
                            .background(Color("ListItemBackground"))
                            .cornerRadius(20)
                        }
                        
                        Button(action: { drawCards(count: 3, spreadType: "三張牌牌陣", iconName: "list.dash") }) {
                            VStack(spacing: 8) {
                                Image(systemName: "list.dash")
                                    .font(.system(size: 32))
                                    .foregroundColor(Color("PrimaryAccent"))
                                Text("三張牌牌陣")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("PrimaryText"))
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                            .padding(.vertical, 10)
                            .background(Color("ListItemBackground"))
                            .cornerRadius(20)
                        }
                        
                        Button(action: { drawCards(count: 3, spreadType: "關係牌陣", iconName: "square.grid.2x2.fill") }) {
                            VStack(spacing: 8) {
                                Image(systemName: "square.grid.2x2.fill")
                                    .font(.system(size: 32))
                                    .foregroundColor(Color("PrimaryAccent"))
                                Text("關係牌陣")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("PrimaryText"))
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                            .padding(.vertical, 10)
                            .background(Color("ListItemBackground"))
                            .cornerRadius(20)
                        }
                        
                        Button(action: { drawCards(count: 10, spreadType: "凱爾特十字", iconName: "square.grid.3x3.fill") }) {
                            VStack(spacing: 8) {
                                Image(systemName: "square.grid.3x3.fill")
                                    .font(.system(size: 32))
                                    .foregroundColor(Color("PrimaryAccent"))
                                Text("凱爾特十字")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("PrimaryText"))
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                            .padding(.vertical, 10)
                            .background(Color("ListItemBackground"))
                            .cornerRadius(20)
                        }
                    }
                }
                .padding(.horizontal, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("AppBackground").ignoresSafeArea())
            .navigationBarHidden(true)
            .sheet(item: $readingResult) { result in
                ReadingResultView(cards: result.cards, spreadType: result.spreadType)
            }
        }
    }
    
    private func drawCards(count: Int, spreadType: String, iconName: String) {
        let deck = cards.isEmpty ? TarotDeck.cards : cards
        let drawnCards = Array(deck.shuffled().prefix(count))
        
        if !drawnCards.isEmpty {
            readingResult = ReadingResult(cards: drawnCards, spreadType: spreadType)
        } else {
            // Fallback for when cards are not loaded (should not happen if TarotDeck.cards is populated)
            if let fallbackCard = TarotDeck.cards.first {
                readingResult = ReadingResult(cards: Array(repeating: fallbackCard, count: count), spreadType: spreadType)
            }
        }
    }
}


#Preview {
    HomeView()
        .modelContainer(ModelContainer.forPreview())
}
