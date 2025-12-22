import SwiftUI
import SwiftData

struct ReadingResultView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode

    let cards: [TarotCardData]
    let spreadType: String
    
    @State private var isSaved = false

    var body: some View {
        ZStack {
            Color("AppBackground").ignoresSafeArea()

            VStack(spacing: 0) {
                // Custom Title
                Text("您的占卜")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("PrimaryText"))
                    .padding(.top)

                ScrollView {
                    VStack(spacing: 20) {
                        Text(spreadType)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color("PrimaryText"))
                            .padding(.bottom, 5)
                        
                        ForEach(cards) { card in
                            VStack(spacing: 16) {
                                Image(card.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200)
                                    .cornerRadius(16)
                                
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
                            .background(Color("ListItemBackground"))
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                }
                
                Spacer() // Pushes content up and button down

                Button(action: saveReading) {
                    Text(isSaved ? "已儲存" : "儲存至日誌")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isSaved ? Color.gray : Color("PrimaryAccent"))
                        .foregroundColor(Color("PrimaryText"))
                        .cornerRadius(40)
                }
                .disabled(isSaved)
                .padding(.horizontal)
                .padding(.bottom) // Add some padding from the bottom safe area
            }
        }
    }
    
    private func saveReading() {
        let interpretation = "這是一段生成的解釋文字。" // Placeholder
        let newEntry = JournalEntryData(date: Date(), spreadType: spreadType, cards: cards, interpretation: interpretation)
        modelContext.insert(newEntry)
        isSaved = true
        
        // Dismiss the view after saving
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    ReadingResultView(cards: [
        TarotCardData(name: "愚者", imageName: "the_fool", details: "代表新的開始、天真、自發性和自由精神。"),
        TarotCardData(name: "魔術師", imageName: "the_magician", details: "代表顯化、足智多謀、力量和靈感。")
    ], spreadType: "三牌陣")
    .modelContainer(ModelContainer.forPreview())
}
