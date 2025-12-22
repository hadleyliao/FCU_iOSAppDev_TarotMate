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

                VStack(spacing: 16) {
                    Text("牌卡圖書館")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("PrimaryText"))
                        .padding(.top)

                    // Custom Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color("SecondaryText"))
                        TextField("搜尋牌卡...", text: $searchText)
                            .foregroundColor(Color("PrimaryText"))
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color("ListItemBackground"))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    Divider()
                        .background(Color("ListItemBackground"))
                        .padding(.horizontal)

                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(filteredCards) { card in
                            NavigationLink(destination: CardDetailView(card: card)) {
                                VStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color("ListItemBackground"))
                                        .aspectRatio(5/9, contentMode: .fit)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(LinearGradient(
                                                    gradient: Gradient(colors: [Color("PrimaryAccent").opacity(0.5), Color("SecondaryAccent").opacity(0.5)]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ), lineWidth: 1)
                                        )
                                    
                                    Text(card.name)
                                        .foregroundColor(Color("SecondaryText"))
                                        .font(.caption)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}


#Preview {
    CardLibraryView()
        .modelContainer(ModelContainer.forPreview())
}
