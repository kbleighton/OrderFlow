import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var menuViewModel = MenuViewModel()
    @StateObject private var cartViewModel = CartViewModel()

    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                HomeView(
                    menuViewModel: menuViewModel,
                    cartViewModel: cartViewModel,
                    authViewModel: authViewModel
                )
            } else {
                LoginView(viewModel: authViewModel)
            }
        }
        .animation(.easeInOut, value: authViewModel.isAuthenticated)
    }
}
