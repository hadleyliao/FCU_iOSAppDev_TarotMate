import SwiftUI
import UserNotifications

struct SettingsView: View {
    @Environment(AppSettings.self) private var appSettings
    
    @AppStorage("isDailyNotificationEnabled") private var isDailyNotificationEnabled = false
    
    @AppStorage("notificationTime") private var notificationTime: Date = {
        var components = DateComponents()
        components.hour = 9
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }()

    @State private var isLightModeEnabled: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CustomHeaderView(title: "設定")
                
                Form {
                    Section(header: Text("外觀")) {
                        Toggle("淺色模式", isOn: $isLightModeEnabled)
                    }
                    
                    Section(header: Text("通知")) {
                        Toggle("每日抽牌通知", isOn: $isDailyNotificationEnabled)
                        
                        if isDailyNotificationEnabled {
                            DatePicker("提醒時間", selection: $notificationTime, displayedComponents: .hourAndMinute)
                        }
                    }
                }
                .toggleStyle(SwitchToggleStyle(tint: Color("PrimaryAccent")))
            }
            .background(Color("AppBackground").ignoresSafeArea())
            .navigationBarHidden(true)
        }
        .onAppear {
            isLightModeEnabled = appSettings.colorScheme == .light
            syncNotificationStatus()
        }
        .onChange(of: isLightModeEnabled) { _, newValue in
            withAnimation {
                appSettings.colorScheme = newValue ? .light : .dark
            }
        }
    }
    
    private func syncNotificationStatus() {
        NotificationManager.shared.getNotificationAuthorizationStatus { status in
            DispatchQueue.main.async {
                if status != .authorized {
                    // If permissions are not granted, ensure our app's setting is off.
                    isDailyNotificationEnabled = false
                }
            }
        }
    }
    
    private func handleNotificationToggle(isOn: Bool) {
        if isOn {
            NotificationManager.shared.requestAuthorization { granted in
                DispatchQueue.main.async {
                    if granted {
                        scheduleNotification()
                    }
                    // Keep the toggle state consistent with the user's action,
                    // even if they denied the permission.
                    isDailyNotificationEnabled = granted
                }
            }
        } else {
            NotificationManager.shared.cancelNotifications()
        }
    }
    
    private func scheduleNotification() {
        let components = Calendar.current.dateComponents([.hour, .minute], from: notificationTime)
        NotificationManager.shared.scheduleDailyNotification(at: components)
    }
}



#Preview {
    SettingsView()
        .environment(AppSettings())
}
