import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AppSettings.self) private var appSettings

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("首頁", systemImage: "house")
                }

            JournalView()
                .tabItem {
                    Label("日誌", systemImage: "book")
                }
            
            CardLibraryView()
                .tabItem {
                    Label("牌卡", systemImage: "rectangle.stack")
                }
            
            SettingsView()
                .tabItem {
                    Label("設定", systemImage: "gear")
                }
        }
        .onAppear {
            TarotDeck.populate(context: modelContext)
        }
        .preferredColorScheme(appSettings.colorScheme)
    }
}

#Preview {
    ContentView()
        .modelContainer(ModelContainer.forPreview())
        .environment(AppSettings())
}
