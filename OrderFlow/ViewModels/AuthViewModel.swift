import Foundation
import Combine

enum AuthError: LocalizedError {
    case invalidCredentials
    case emptyFields

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid username or password. Please try again."
        case .emptyFields:
            return "Please enter both username and password."
        }
    }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String? = nil

    // Demo credentials
    private let validUsername = "demo"
    private let validPassword = "password"

    func login() async {
        guard !username.isEmpty && !password.isEmpty else {
            errorMessage = AuthError.emptyFields.errorDescription
            return
        }

        errorMessage = nil
        isLoading = true

        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_500_000_000)

        if username == validUsername && password == validPassword {
            isAuthenticated = true
        } else {
            errorMessage = AuthError.invalidCredentials.errorDescription
        }

        isLoading = false
    }

    func logout() {
        username = ""
        password = ""
        isAuthenticated = false
        errorMessage = nil
    }
}
