import Foundation
import SwiftData

class TarotDeck {
    static let cards: [TarotCardData] = [
        TarotCardData(name: "愚者", imageName: "the_fool", details: "代表新的開始、天真、自發性和自由精神。"),
        TarotCardData(name: "魔術師", imageName: "the_magician", details: "代表顯化、足智多謀、力量和靈感。"),
        TarotCardData(name: "女祭司", imageName: "the_high_priestess", details: "代表直覺、神聖女性、潛意識和神秘。"),
        TarotCardData(name: "皇后", imageName: "the_empress", details: "代表豐盛、滋養和創造力。"),
        TarotCardData(name: "皇帝", imageName: "the_emperor", details: "代表權威、結構和控制。"),
        TarotCardData(name: "教皇", imageName: "the_hierophant", details: "代表傳統、宗教和精神指導。"),
        TarotCardData(name: "戀人", imageName: "the_lovers", details: "代表愛、結合和選擇。"),
        TarotCardData(name: "戰車", imageName: "the_chariot", details: "代表勝利、意志力和控制。"),
        TarotCardData(name: "力量", imageName: "strength", details: "代表勇氣、同情和內在力量。"),
        TarotCardData(name: "隱者", imageName: "the_hermit", details: "代表內省、獨處和尋求真理。"),
        TarotCardData(name: "命運之輪", imageName: "wheel_of_fortune", details: "代表變化、命運和轉折點。"),
        TarotCardData(name: "正義", imageName: "justice", details: "代表公平、真理和法律。"),
        TarotCardData(name: "倒吊人", imageName: "the_hanged_man", details: "代表犧牲、新視角和暫停。"),
        TarotCardData(name: "死亡", imageName: "death", details: "代表結束、轉變和重生。"),
        TarotCardData(name: "節制", imageName: "temperance", details: "代表平衡、節制和耐心。"),
        TarotCardData(name: "惡魔", imageName: "the_devil", details: "代表誘惑、束縛和物質主義。"),
        TarotCardData(name: "高塔", imageName: "the_tower", details: "代表災難、啟示和突然的改變。"),
        TarotCardData(name: "星星", imageName: "the_star", details: "代表希望、靈感和平靜。"),
        TarotCardData(name: "月亮", imageName: "the_moon", details: "代表幻覺、直覺和潛意識。"),
        TarotCardData(name: "太陽", imageName: "the_sun", details: "代表喜悅、成功和活力。"),
        TarotCardData(name: "審判", imageName: "judgment", details: "代表覺醒、審判和重生。"),
        TarotCardData(name: "世界", imageName: "the_world", details: "代表完成、成就和圓滿。")    ]
    
    static func populate(context: ModelContext) {
        // Check if data already exists
        let descriptor = FetchDescriptor<TarotCardData>()
        if let count = try? context.fetchCount(descriptor), count > 0 {
            return // Data is already populated
        }
        
        // Insert all cards into the context
        for card in cards {
            context.insert(card)
        }
    }
}
