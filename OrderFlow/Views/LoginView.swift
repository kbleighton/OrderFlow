import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Logo / Header
                VStack(spacing: 12) {
                    Image(systemName: "bag.fill")
                        .font(.system(size: 64))
                        .foregroundColor(.orange)
                        .accessibilityIdentifier("login_logo_image")

                    Text("OrderFlow")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .accessibilityIdentifier("login_app_title_label")

                    Text("Fresh food, fast delivery")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .accessibilityIdentifier("login_tagline_label")
                }
                .padding(.top, 60)
                .padding(.bottom, 48)

                // Form
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Username")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        TextField("Enter username", text: $viewModel.username)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .accessibilityIdentifier("login_username_field")
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Password")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        SecureField("Enter password", text: $viewModel.password)
                            .textFieldStyle(.roundedBorder)
                            .accessibilityIdentifier("login_password_field")
                    }

                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .accessibilityIdentifier("login_error_label")
                    }

                    Button {
                        Task {
                            await viewModel.login()
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.orange)
                                .frame(height: 50)

                            if viewModel.isLoading {
                                HStack(spacing: 10) {
                                    ProgressView()
                                        .tintColor(.white)
                                        .accessibilityIdentifier("login_loading_indicator")
                                    Text("Signing in...")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                }
                            } else {
                                Text("Sign In")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }
                        }
                    }
                    .disabled(viewModel.isLoading)
                    .accessibilityIdentifier("login_button")

                    Text("Demo credentials: demo / password")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .accessibilityIdentifier("login_demo_hint_label")
                }
                .padding(.horizontal, 32)

                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}
