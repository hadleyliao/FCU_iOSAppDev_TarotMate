import SwiftUI

struct SettingsView: View {
    @State private var isLightModeOn = false
    @State private var isNotificationOn = true

    var body: some View {
        NavigationView {
            ZStack {
                Color("AppBackground").ignoresSafeArea()
                
                Form {
                    Section(header: Text("外觀").foregroundColor(Color("SecondaryText"))) {
                        Toggle("淺色模式", isOn: $isLightModeOn)
                            .foregroundColor(Color("PrimaryText"))
                    }
                    
                    Section(header: Text("通知").foregroundColor(Color("SecondaryText"))) {
                        Toggle("每日抽牌通知", isOn: $isNotificationOn)
                            .foregroundColor(Color("PrimaryText"))
                    }
                }
                .toggleStyle(SwitchToggleStyle(tint: Color("PrimaryAccent")))
            }
            .navigationTitle("設定")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}


#Preview {
    SettingsView()
}
