import SwiftUI
import SwiftData

struct CardDetailView: View {
    let card: TarotCardData

    var body: some View {
        ZStack {
            Color("AppBackground").ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    Image(card.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(LinearGradient(
                                    gradient: Gradient(colors: [Color("PrimaryAccent").opacity(0.5), Color("SecondaryAccent").opacity(0.5)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ), lineWidth: 2)
                        )
                    
                    Text(card.details)
                        .font(.body)
                        .foregroundColor(Color("SecondaryText"))
                        .padding(.horizontal)
                }
                .padding()
            }
            .navigationTitle(card.name)
            .navigationBarTitleDisplayMode(.inline)
            // Re-adding the appearance customization for this view specifically
            .toolbarBackground(Color("AppBackground"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

#Preview {
    // Need to create mock data for preview
    let container = ModelContainer.forPreview()
    let descriptor = FetchDescriptor<TarotCardData>()
    let card = try! container.mainContext.fetch(descriptor).first!
    
    return NavigationView {
        CardDetailView(card: card)
    }
    .modelContainer(container)
}
