# 🃏 塔羅牌抽卡記錄應用程式 (TarotMate)

## 📱 畫面截圖
![APP畫面](https://github.com/hadleyliao/FCU_iOSAppDev_TarotMate/blob/main/screenshot/1.png)
![過場畫面](https://github.com/hadleyliao/FCU_iOSAppDev_TarotMate/blob/main/screenshot/2.png)
![主畫面](https://github.com/hadleyliao/FCU_iOSAppDev_TarotMate/blob/main/screenshot/3.png)
![主畫面](https://github.com/hadleyliao/FCU_iOSAppDev_TarotMate/blob/main/screenshot/4.png)
![主畫面](https://github.com/hadleyliao/FCU_iOSAppDev_TarotMate/blob/main/screenshot/5.png)
![主畫面](https://github.com/hadleyliao/FCU_iOSAppDev_TarotMate/blob/main/screenshot/6.png)
![主畫面](https://github.com/hadleyliao/FCU_iOSAppDev_TarotMate/blob/main/screenshot/7.png)
![主畫面](https://github.com/hadleyliao/FCU_iOSAppDev_TarotMate/blob/main/screenshot/8.png)
![主畫面](https://github.com/hadleyliao/FCU_iOSAppDev_TarotMate/blob/main/screenshot/9.png)
![主畫面](https://github.com/hadleyliao/FCU_iOSAppDev_TarotMate/blob/main/screenshot/10.png)
![主畫面](https://github.com/hadleyliao/FCU_iOSAppDev_TarotMate/blob/main/screenshot/11.png)
![主畫面](https://github.com/hadleyliao/FCU_iOSAppDev_TarotMate/blob/main/screenshot/12.png)
---

## 📋 專案概述

TarotMate 是一款使用 SwiftUI 和 SwiftData 開發的 iOS 塔羅牌占卜應用程式，提供每日抽牌、多種牌陣占卜、牌卡圖鑑查詢及占卜記錄管理功能。應用程式採用現代化的設計風格，支援深色/淺色模式切換，並提供每日提醒通知功能。

---

## ✨ 功能特色

### 1. **多元占卜模式**
- **每日抽牌**：提供單張牌卡的每日指引
- **三張牌牌陣**：過去-現在-未來時間線占卜
- **關係牌陣**：專注於人際關係的三牌占卜

### 2. **完整的牌卡圖鑑**
- 收錄完整塔羅牌卡（大阿爾卡納牌）
- 每張牌卡附有詳細解說
- 支援搜尋功能快速查找特定牌卡
- 3欄網格式瀏覽設計

### 3. **占卜日誌系統**
- 自動記錄每次占卜結果
- 按時間倒序排列，方便回顧
- 可查看歷史占卜的詳細內容
- 支援刪除不需要的記錄

### 4. **智慧通知提醒**
- 可設定每日抽牌提醒時間
- 自訂通知時段
- 整合 iOS 原生通知權限管理

### 5. **主題外觀切換**
- 支援深色模式（預設）
- 支援淺色模式
- 自訂配色方案

---

## 🎯 核心功能

### **首頁 (HomeView)**
- 顯示月亮星星圖示及引導文字「心之所想，心之所向」
- 提供三種占卜按鈕：
  - 每日抽牌（單張）
  - 三張牌牌陣
  - 關係牌陣
- 隨機抽取塔羅牌並導向結果頁面

### **占卜結果頁 (ReadingResultView)**
- 展示抽取的牌卡圖像
- 顯示牌卡名稱及詳細解說
- 提供「儲存至日誌」功能
- 儲存後自動返回首頁

### **占卜日誌 (JournalView)**
- 列表顯示所有占卜記錄
- 顯示日期時間、牌陣類型及抽到的牌卡
- 三牌陣特殊顯示格式：「過去: XXX, 現在: XXX, 未來: XXX」
- 支援左滑刪除功能
- 點擊進入詳細頁面 (JournalDetailView)

### **牌卡圖鑑 (CardLibraryView)**
- 3欄網格式排列所有塔羅牌
- 即時搜尋功能
- 牌卡圖片帶有漸層邊框裝飾
- 點擊進入牌卡詳情頁 (CardDetailView)

### **設定頁 (SettingsView)**
- **外觀設定**：淺色/深色模式切換
- **通知設定**：
  - 開關每日抽牌通知
  - 自訂提醒時間（時與分）
  - 自動同步系統通知權限狀態

---

## 🎨 視覺效果

### **設計風格**
- **極簡神秘**：採用深色背景搭配金色/紫色漸層點綴
- **圓角設計**：所有卡片和按鈕使用圓角矩形，提升親和力
- **漸層邊框**：牌卡圖片使用 PrimaryAccent 到 SecondaryAccent 的漸層描邊
- **SF Symbols 圖示**：大量使用系統圖示（moon.stars.fill, sun.max.fill 等）

### **色彩系統**
```swift
Color("AppBackground")         // 應用背景色
Color("PrimaryText")           // 主要文字色
Color("SecondaryText")         // 次要文字色
Color("PrimaryAccent")         // 主要強調色（如月亮圖示）
Color("SecondaryAccent")       // 次要強調色（如過去現在未來標籤）
Color("ListItemBackground")    // 列表項目背景
```

### **互動動畫**
- 切換深淺色模式時使用 `withAnimation` 平滑過渡
- 刪除日誌條目時帶有動畫效果
- 儲存占卜記錄後按鈕狀態變化（已儲存/灰色）

---

## 💡 技術亮點

### **1. SwiftData 資料持久化**
- 使用 `@Model` 宏定義資料模型
- `TarotCardData`：塔羅牌資料（id, name, imageName, details）
- `JournalEntryData`：占卜記錄（id, date, spreadType, cards, interpretation）
- `@Relationship(deleteRule: .cascade)`：確保刪除日誌時連帶刪除關聯牌卡
- `ModelContainer` 管理資料庫生命週期

### **2. SwiftUI 現代化開發**
- `@Query` 自動同步資料查詢
- `@Environment` 注入全域設定（modelContext, AppSettings）
- `@AppStorage` 儲存用戶偏好設定（通知時間、開關狀態）
- `@Observable` 宏實現響應式 AppSettings
- NavigationView + TabView 建構應用架構

### **3. 通知管理 (NotificationManager)**
- 單例模式 (`shared`) 管理通知
- `UNUserNotificationCenter` 整合
- 支援每日定時通知 (UNCalendarNotificationTrigger)
- 權限狀態檢查及自動同步

### **4. 預覽支援**
- `ModelContainer.forPreview()` 提供記憶體內資料庫
- 所有 View 都附有 `#Preview` 宏
- 便於開發時即時預覽

### **5. 模組化設計**
- TarotDeck.populate()：統一資料初始化
- NotificationManager：通知邏輯封裝
- AppSettings：全域主題管理
- 各 View 職責明確，便於維護

---

## 🏗️ 專案架構

```
Tarot3/
├── App Layer
│   ├── Tarot3App.swift              # App 入口，設定 ModelContainer
│   └── ContentView.swift            # TabView 主架構
│
├── Views (UI Layer)
│   ├── HomeView.swift               # 首頁：選擇占卜類型
│   ├── ReadingResultView.swift     # 占卜結果展示與儲存
│   ├── JournalView.swift            # 占卜日誌列表
│   ├── JournalDetailView.swift     # 日誌詳情頁
│   ├── CardLibraryView.swift       # 牌卡圖鑑
│   ├── CardDetailView.swift        # 單張牌卡詳情
│   ├── SettingsView.swift           # 設定頁
│   └── CustomHeaderView.swift      # 自訂 Header 元件
│
├── Models (Data Layer)
│   ├── TarotCardData.swift          # 塔羅牌資料模型
│   ├── JournalEntryData.swift      # 占卜記錄模型
│   └── TarotDeck.swift              # 塔羅牌資料來源
│
├── Managers (Business Logic)
│   ├── NotificationManager.swift    # 通知管理
│   └── AppSettings.swift            # 全域設定（色彩主題）
│
├── Utilities
│   └── ModelContainer+Preview.swift # Preview 資料容器擴展
│
├── Resources
│   ├── Assets.xcassets              # 圖片資源（牌卡圖片、色彩）
│   └── Launch Screen.storyboard    # 啟動畫面
│
└── Project Files
    └── Tarot3.xcodeproj
```

---

## 📄 檔案說明

### **核心檔案**

| 檔案名稱 | 功能說明 |
|---------|---------|
| `Tarot3App.swift` | 應用程式進入點，初始化 ModelContainer 和 AppSettings |
| `ContentView.swift` | 主要 TabView 架構，包含四個頁籤 |
| `TarotCardData.swift` | 定義塔羅牌資料結構（@Model） |
| `JournalEntryData.swift` | 定義占卜記錄資料結構，與 TarotCardData 有關聯 |
| `TarotDeck.swift` | 儲存所有塔羅牌資料及 populate 方法 |

### **View 檔案**

| 檔案名稱 | 功能說明 |
|---------|---------|
| `HomeView.swift` | 首頁，提供三種占卜按鈕及抽牌邏輯 |
| `ReadingResultView.swift` | 顯示占卜結果，可儲存至日誌 |
| `JournalView.swift` | 占卜日誌列表，支援刪除 |
| `JournalDetailView.swift` | 日誌詳情，展示完整牌卡解說 |
| `CardLibraryView.swift` | 牌卡圖鑑，3欄網格 + 搜尋 |
| `CardDetailView.swift` | 單張牌卡詳細資訊 |
| `SettingsView.swift` | 設定頁面（主題、通知） |
| `CustomHeaderView.swift` | 可重用的自訂標題元件 |

### **管理類別**

| 檔案名稱 | 功能說明 |
|---------|---------|
| `NotificationManager.swift` | 單例模式，管理通知權限、排程與取消 |
| `AppSettings.swift` | @Observable 類別，管理色彩主題 |
| `ModelContainer+Preview.swift` | 擴展 ModelContainer，提供 Preview 用記憶體資料庫 |

---

## 👤 用戶體驗

### **流暢的占卜流程**
1. **開啟應用** → 看到精美的啟動畫面
2. **首頁選擇** → 三種占卜模式一目了然
3. **抽牌動作** → 點擊按鈕立即隨機抽取
4. **查看結果** → 美觀的卡片展示 + 詳細解說
5. **儲存記錄** → 一鍵儲存至日誌，方便日後回顧
6. **歷史回顧** → 在日誌頁面查看所有占卜歷史

### **人性化設計**
- **搜尋功能**：在牌卡圖鑑快速找到想了解的牌
- **三牌陣特殊顯示**：過去-現在-未來清楚標示
- **刪除便捷**：左滑即可刪除不需要的記錄
- **通知提醒**：不會忘記每日抽牌

### **視覺一致性**
- 所有頁面使用統一的色彩系統
- 圓角設計貫穿整個應用
- 漸層點綴增加神秘感
- 深淺色模式都經過精心設計

### **效能優化**
- SwiftData 自動管理資料庫
- `@Query` 自動更新視圖，無需手動刷新
- LazyVGrid 懶加載，提升圖鑑瀏覽效能
- 記憶體內預覽資料庫，不影響真實資料

---

## 🛠️ 開發環境

- **開發工具**：Xcode
- **程式語言**：Swift
- **UI 框架**：SwiftUI
- **資料持久化**：SwiftData
- **最低支援版本**：iOS 17.0+
