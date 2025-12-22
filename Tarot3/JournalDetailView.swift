import SwiftUI
import SwiftData

struct JournalDetailView: View {
    let entry: JournalEntryData

    var body: some View {
        NavigationView { // Keep NavigationView for the back button
            ZStack {
                Color("AppBackground").ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 0) {
                    Text("日誌詳情")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("PrimaryText"))
                        .padding(.top)
                    
                    Divider()
                        .background(Color("ListItemBackground"))
                        .padding(.horizontal)
                        .padding(.bottom)
                        
                    ScrollView {
                        VStack(alignment: .leading, spacing: 24) {
                            HStack {
                                Text(entry.spreadType)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("PrimaryText"))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Color("PrimaryAccent").opacity(0.2))
                                    .cornerRadius(8)
                            }
                            
                            Text(entry.date, format: .dateTime.year().month().day())
                                .font(.headline)
                                .foregroundColor(Color("SecondaryText"))
                            
                            ForEach(entry.cards) { card in
                                VStack(alignment: .center, spacing: 16) {
                                    Image(card.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200)
                                        .cornerRadius(16)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(LinearGradient(
                                                    gradient: Gradient(colors: [Color("PrimaryAccent").opacity(0.5), Color("SecondaryAccent").opacity(0.5)]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ), lineWidth: 1)
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
                        Spacer() // Added to push content up and fill remaining space
                    }
                }
            }
            .navigationBarHidden(true) // Hide the original navigation bar
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
