import SwiftUI
import SwiftData

struct ReadingResult: Identifiable {
    let id = UUID()
    let cards: [TarotCardData]
    let spreadType: String
}

struct HomeView: View {
    @Query private var cards: [TarotCardData]
    @State private var readingResult: ReadingResult?
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Color
                Color("AppBackground")
                    .ignoresSafeArea()

                VStack {
                    Spacer()

                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "moon.stars.fill")
                            .font(.system(size: 80))
                            .foregroundColor(Color("PrimaryAccent"))

                        Text("🃏 心之所想，心之所向 🃏")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color("PrimaryText"))

                        Text("讓牌卡引導您的一天。")
                            .font(.body)
                            .foregroundColor(Color("SecondaryText"))
                    }

                    Spacer()
                    Spacer()

                    // Action Buttons
                    VStack(spacing: 16) {
                        Button(action: drawDailyCard) {
                            Text("抽取每日牌卡")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("PrimaryAccent"))
                                .foregroundColor(Color("PrimaryText"))
                                .cornerRadius(40)
                        }

                        Button(action: {
                            // TODO: Action for choosing a spread
                        }) {
                            Text("選擇牌陣")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("ListItemBackground").opacity(0.5))
                                .foregroundColor(Color("PrimaryText"))
                                .cornerRadius(40)
                        }
                    }
                    .padding(.horizontal, 30)
                }
            }
            .navigationBarHidden(true)
            .sheet(item: $readingResult) { result in
                ReadingResultView(cards: result.cards, spreadType: result.spreadType)
            }
        }
    }
    
    private func drawDailyCard() {
        if let card = cards.randomElement() {
            readingResult = ReadingResult(cards: [card], spreadType: "每日牌卡")
        } else {
            // Handle case where cards are not loaded yet, though unlikely
            if let fallbackCard = TarotDeck.cards.first {
                readingResult = ReadingResult(cards: [fallbackCard], spreadType: "每日牌卡")
            }
        }
    }
}


#Preview {
    HomeView()
        .modelContainer(for: [TarotCardData.self, JournalEntryData.self], inMemory: true)
}
