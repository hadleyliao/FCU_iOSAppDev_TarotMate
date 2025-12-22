import SwiftUI
import UserNotifications

struct SettingsView: View {
    @Environment(AppSettings.self) private var appSettings
    
    @State private var isNotificationEnabled = false
    @AppStorage("notificationTime") private var notificationTime: Date = {
        var components = DateComponents()
        components.hour = 9
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }()

    private var isLightModeOn: Binding<Bool> {
        Binding(
            get: { appSettings.colorScheme == .light },
            set: { ison in
                appSettings.colorScheme = ison ? .light : .dark
            }
        )
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CustomHeaderView(title: "設定")
                
                Form {
                    Section(header: Text("外觀")) {
                        Toggle("淺色模式", isOn: isLightModeOn)
                    }
                    
                    Section(header: Text("通知")) {
                        Toggle("每日抽牌通知", isOn: $isNotificationEnabled)
                        
                        if isNotificationEnabled {
                            DatePicker("提醒時間", selection: $notificationTime, displayedComponents: .hourAndMinute)
                        }
                    }
                }
                .foregroundColor(Color("PrimaryText"))
                .toggleStyle(SwitchToggleStyle(tint: Color("PrimaryAccent")))
            }
            .background(Color("AppBackground").ignoresSafeArea())
            .navigationBarHidden(true)
        }
        .onAppear(perform: checkNotificationStatus)
        .onChange(of: isNotificationEnabled) { _, newValue in
            handleNotificationToggle(isOn: newValue)
        }
        .onChange(of: notificationTime) { _, _ in
            // Reschedule notification if the time changes and notifications are enabled
            if isNotificationEnabled {
                scheduleNotification()
            }
        }
    }
    
    private func checkNotificationStatus() {
        NotificationManager.shared.getNotificationAuthorizationStatus { status in
            DispatchQueue.main.async {
                isNotificationEnabled = (status == .authorized)
            }
        }
    }
    
    private func handleNotificationToggle(isOn: Bool) {
        if isOn {
            NotificationManager.shared.requestAuthorization { granted in
                DispatchQueue.main.async {
                    if granted {
                        scheduleNotification()
                        isNotificationEnabled = true
                    } else {
                        // User denied permission
                        isNotificationEnabled = false
                    }
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
