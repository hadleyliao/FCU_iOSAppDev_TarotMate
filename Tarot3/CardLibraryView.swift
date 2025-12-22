import SwiftUI
import SwiftData

struct CardLibraryView: View {
    @Query(sort: \TarotCardData.name) private var cards: [TarotCardData]
    @State private var searchText = ""

    private var filteredCards: [TarotCardData] {
        if searchText.isEmpty {
            return cards
        } else {
            return cards.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    var body: some View {
        NavigationView {
            ZStack {
                Color("AppBackground").ignoresSafeArea()

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredCards) { card in
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("PrimaryAccent").opacity(0.3))
                                    .aspectRatio(5/9, contentMode: .fit)
                                
                                Text(card.name)
                                    .foregroundColor(Color("SecondaryText"))
                                    .font(.caption)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("牌卡圖書館")
            .searchable(text: $searchText, prompt: "搜尋牌卡...")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}


#Preview {
    let container = try! ModelContainer(for: [TarotCardData.self, JournalEntryData.self], configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    TarotDeck.populate(context: container.mainContext)
    
    CardLibraryView()
        .modelContainer(for: [TarotCardData.self, JournalEntryData.self], inMemory: true)
}
