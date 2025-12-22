import SwiftUI
import SwiftData

struct JournalView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \JournalEntryData.date, order: .reverse) private var entries: [JournalEntryData]

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                CustomHeaderView(title: "占卜日誌")

                List {
                    ForEach(entries) { entry in
                        NavigationLink(destination: JournalDetailView(entry: entry)) {
                            JournalEntryCardView(entry: entry)
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .padding(.bottom, 8)
                    }
                    .onDelete(perform: deleteEntries)
                }
                .listStyle(.plain)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("AppBackground").ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }
    
    private func deleteEntries(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(entries[index])
            }
        }
    }
}

struct JournalEntryCardView: View {
    let entry: JournalEntryData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(entry.date, format: .dateTime.year().month().day().hour().minute())
                .font(.caption)
                .foregroundColor(Color("SecondaryText"))
            
            Text(entry.spreadType)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color("PrimaryText"))
            
            if entry.spreadType == "三牌陣" && entry.cards.count == 3 {
                ThreeCardSpreadRow(cards: entry.cards)
            } else {
                Text(entry.cards.map { $0.name }.joined(separator: ", "))
                    .font(.body)
                    .foregroundColor(Color("PrimaryText").opacity(0.8))
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("ListItemBackground"))
        .cornerRadius(12)
    }
}

struct ThreeCardSpreadRow: View {
    let cards: [TarotCardData]
    
    var body: some View {
        HStack(spacing: 4) {
            Text("過去:").foregroundColor(Color("SecondaryAccent"))
            Text(cards[0].name + ",")
            
            Text("現在:").foregroundColor(Color("SecondaryAccent"))
            Text(cards[1].name + ",")
            
            Text("未來:").foregroundColor(Color("SecondaryAccent"))
            Text(cards[2].name)
        }
        .font(.body)
        .foregroundColor(Color("PrimaryText").opacity(0.8))
    }
}


#Preview {
    JournalView()
        .modelContainer(ModelContainer.forPreview())
}
