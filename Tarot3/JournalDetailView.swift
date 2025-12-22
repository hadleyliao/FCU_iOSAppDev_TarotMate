import SwiftUI
import SwiftData

struct JournalDetailView: View {
    let entry: JournalEntryData

    var body: some View {
        ZStack {
            Color("AppBackground").ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text(entry.spreadType)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("PrimaryText"))
                    
                    Text(entry.date, format: .dateTime.year().month().day())
                        .font(.headline)
                        .foregroundColor(Color("SecondaryText"))
                    
                    ForEach(entry.cards) { card in
                        VStack(alignment: .center, spacing: 16) {
                            // Placeholder for card image
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color("PrimaryAccent").opacity(0.3))
                                .frame(width: 200, height: 360)
                                .overlay(
                                    Text(card.name)
                                        .font(.title)
                                        .foregroundColor(Color("PrimaryText"))
                                )
                            
                            Text(card.name)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color("PrimaryText"))
                            
                            Text(card.details)
                                .font(.body)
                                .foregroundColor(Color("SecondaryText"))
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("綜合解說")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color("PrimaryText"))
                        Text(entry.interpretation)
                            .font(.body)
                            .foregroundColor(Color("SecondaryText"))
                    }
                }
                .padding()
            }
            .navigationTitle("日誌詳情")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    // Need to create mock data for preview
    let container = try! ModelContainer(for: JournalEntryData.self, TarotCardData.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let card = TarotCardData(name: "愚者", imageName: "the_fool", details: "代表新的開始、天真、自發性和自由精神。")
    let entry = JournalEntryData(date: Date(), spreadType: "每日牌卡", cards: [card], interpretation: "這是一段綜合解說的範例文字。")
    
    NavigationView {
        JournalDetailView(entry: entry)
    }
    .modelContainer(container)
}
