import SwiftUI
import SwiftData

struct JournalView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \JournalEntryData.date, order: .reverse) private var entries: [JournalEntryData]

    var body: some View {
        NavigationView {
            ZStack {
                Color("AppBackground").ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Text("占卜日誌")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("PrimaryText"))
                        .padding(.horizontal)
                        .padding(.top)

                    List {
                        ForEach(entries) { entry in
                            NavigationLink(destination: JournalDetailView(entry: entry)) {
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
                                .foregroundColor(Color("PrimaryText")) // Explicitly set foreground color for the link content
                            }
                            .listRowBackground(Color("ListItemBackground"))
                        }
                        .onDelete(perform: deleteEntries)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationBarHidden(true) // Hide the original navigation bar
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
        .modelContainer(ModelContainer.forPreview())
}
