import SwiftUI

struct SettingsView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @StateObject private var viewModel = SettingsViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                // Notifications section
                Section {
                    Toggle(isOn: $viewModel.notificationsEnabled) {
                        Label("Push Notifications", systemImage: "bell.fill")
                    }
                    .accessibilityIdentifier("settings_notifications_toggle")

                    Toggle(isOn: $viewModel.soundEnabled) {
                        Label("Sound", systemImage: "speaker.wave.2.fill")
                    }
                    .accessibilityIdentifier("settings_sound_toggle")

                    Toggle(isOn: $viewModel.promotionalEmailsEnabled) {
                        Label("Promotional Emails", systemImage: "envelope.fill")
                    }
                    .accessibilityIdentifier("settings_promo_emails_toggle")
                } header: {
                    Text("Notifications")
                        .accessibilityIdentifier("settings_notifications_section_header")
                }

                // Privacy section
                Section {
                    Toggle(isOn: $viewModel.locationEnabled) {
                        Label("Location Services", systemImage: "location.fill")
                    }
                    .accessibilityIdentifier("settings_location_toggle")

                    Toggle(isOn: $viewModel.darkModeEnabled) {
                        Label("Dark Mode", systemImage: "moon.fill")
                    }
                    .accessibilityIdentifier("settings_dark_mode_toggle")
                } header: {
                    Text("Preferences")
                        .accessibilityIdentifier("settings_preferences_section_header")
                }

                // Account section
                Section {
                    HStack {
                        Label("Username", systemImage: "person.fill")
                        Spacer()
                        Text(authViewModel.username.isEmpty ? "demo" : authViewModel.username)
                            .foregroundColor(.secondary)
                            .accessibilityIdentifier("settings_username_value_label")
                    }
                    .accessibilityIdentifier("settings_username_row")

                    NavigationLink(destination: AboutView()) {
                        Label("About OrderFlow", systemImage: "info.circle.fill")
                    }
                    .accessibilityIdentifier("settings_about_row")
                } header: {
                    Text("Account")
                        .accessibilityIdentifier("settings_account_section_header")
                }

                // App info section
                Section {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("\(viewModel.appVersion) (\(viewModel.buildNumber))")
                            .foregroundColor(.secondary)
                            .accessibilityIdentifier("settings_version_label")
                    }
                    .accessibilityIdentifier("settings_version_row")
                } header: {
                    Text("App Info")
                }

                // Logout section
                Section {
                    Button(role: .destructive) {
                        authViewModel.logout()
                        dismiss()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Sign Out")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    .accessibilityIdentifier("settings_logout_button")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .accessibilityIdentifier("settings_done_button")
                }
            }
        }
    }
}

struct AboutView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "bag.fill")
                .font(.system(size: 64))
                .foregroundColor(.orange)
                .accessibilityIdentifier("about_logo_image")

            Text("OrderFlow")
                .font(.largeTitle)
                .fontWeight(.bold)
                .accessibilityIdentifier("about_app_name_label")

            Text("A demo app for the XCUITest Automation Course.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .accessibilityIdentifier("about_description_label")

            Text("Version 1.0.0")
                .font(.caption)
                .foregroundColor(.secondary)
                .accessibilityIdentifier("about_version_label")
        }
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}
