import Foundation
import Combine

@MainActor
class SettingsViewModel: ObservableObject {
    @Published var notificationsEnabled: Bool = true
    @Published var locationEnabled: Bool = false
    @Published var promotionalEmailsEnabled: Bool = true
    @Published var soundEnabled: Bool = true
    @Published var darkModeEnabled: Bool = false

    let appVersion: String = "1.0.0"
    let buildNumber: String = "100"
}
