import SwiftUI
import SwiftData

struct ReadingResultView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode

    let cards: [TarotCardData]
    let spreadType: String
    
    @State private var isSaved = false

    var body: some View {
        NavigationView {
            ZStack {
                Color("AppBackground").ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        Text(spreadType)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color("PrimaryText"))
                        
                        ForEach(cards) { card in
                            VStack {
                                Text(card.name)
                                    .font(.headline)
                                    .foregroundColor(Color("PrimaryAccent"))
                                Text(card.details)
                                    .font(.body)
                                    .foregroundColor(Color("SecondaryText"))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }
                            .padding()
                            .background(Color("ListItemBackground"))
                            .cornerRadius(10)
                        }
                        
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
                    }
                    .padding()
                }
            }
            .navigationTitle("您的占卜")
            .navigationBarItems(trailing: Button("完成") {
                presentationMode.wrappedValue.dismiss()
            })
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func saveReading() {
        let interpretation = "這是一段生成的解釋文字。" // Placeholder
        let newEntry = JournalEntryData(date: Date(), spreadType: spreadType, cards: cards, interpretation: interpretation)
        modelContext.insert(newEntry)
        isSaved = true
    }
}

#Preview {
    ReadingResultView(cards: [
        TarotCardData(name: "愚者", imageName: "the_fool", details: "代表新的開始、天真、自發性和自由精神。"),
        TarotCardData(name: "魔術師", imageName: "the_magician", details: "代表顯化、足智多謀、力量和靈感。")
    ], spreadType: "三牌陣")
    .modelContainer(ModelContainer.forPreview())
}
