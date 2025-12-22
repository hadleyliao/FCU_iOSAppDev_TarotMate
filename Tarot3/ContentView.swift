import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("首頁", systemImage: "house")
                }

            CardLibraryView()
                .tabItem {
                    Label("牌卡", systemImage: "rectangle.stack")
                }

            JournalView()
                .tabItem {
                    Label("日誌", systemImage: "book")
                }

            SettingsView()
                .tabItem {
                    Label("設定", systemImage: "gear")
                }
        }
        .onAppear {
            TarotDeck.populate(context: modelContext)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [TarotCardData.self, JournalEntryData.self], inMemory: true)
}
