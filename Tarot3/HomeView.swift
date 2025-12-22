import SwiftUI
import SwiftData

struct HomeView: View {
    @Query private var cards: [TarotCardData]
    @State private var showReadingResult = false
    @State private var drawnCards: [TarotCardData] = []
    
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

                        Text("神秘面紗")
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
            .sheet(isPresented: $showReadingResult) {
                if !drawnCards.isEmpty {
                    ReadingResultView(cards: drawnCards, spreadType: "每日牌卡")
                }
            }
        }
    }
    
    private func drawDailyCard() {
        drawnCards = [cards.randomElement() ?? TarotDeck.cards[0]]
        showReadingResult = true
    }
}


#Preview {
    HomeView()
        .modelContainer(for: [TarotCardData.self, JournalEntryData.self], inMemory: true)
}
