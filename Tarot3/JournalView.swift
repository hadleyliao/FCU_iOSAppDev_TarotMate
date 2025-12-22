import SwiftUI
import SwiftData

struct JournalView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \JournalEntryData.date, order: .reverse) private var entries: [JournalEntryData]

    var body: some View {
        NavigationView {
            ZStack {
                Color("AppBackground").ignoresSafeArea()
                
                List {
                    ForEach(entries) { entry in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(entry.date, format: .dateTime.year().month().day().hour().minute())
                                .font(.subheadline)
                                .foregroundColor(Color("SecondaryText"))
                            Text(entry.spreadType)
                                .font(.headline)
                                .foregroundColor(Color("PrimaryText"))
                            Text(entry.cards.map { $0.name }.joined(separator: ", "))
                                .font(.body)
                                .foregroundColor(Color("PrimaryText").opacity(0.8))
                        }
                        .padding(.vertical, 8)
                        .listRowBackground(Color("ListItemBackground"))
                    }
                    .onDelete(perform: deleteEntries)
                }
                .listStyle(.plain)
            }
            .navigationTitle("占卜日誌")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                EditButton()
            }
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(named: "AppBackground")
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "PrimaryText")!]
            appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "PrimaryText")!]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
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


#Preview {
    JournalView()
        .modelContainer(for: [TarotCardData.self, JournalEntryData.self], inMemory: true)
}
