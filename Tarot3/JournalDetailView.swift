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
                    

                }
                .padding()
            }
            .navigationTitle("日誌詳情")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(named: "AppBackground") // Use AppBackground for consistency
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "PrimaryText")!]
            appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "PrimaryText")!]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    let container = ModelContainer.forPreview()
    let fetchDescriptor = FetchDescriptor<JournalEntryData>()
    let entry = try! container.mainContext.fetch(fetchDescriptor).first!
    
    return NavigationView {
        JournalDetailView(entry: entry)
    }
    .modelContainer(container)
}
