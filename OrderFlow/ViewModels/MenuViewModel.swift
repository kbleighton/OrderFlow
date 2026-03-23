import Foundation
import Combine

@MainActor
class MenuViewModel: ObservableObject {
    @Published var menuItems: [MenuItem] = []
    @Published var selectedCategory: MenuCategory? = nil
    @Published var isLoading: Bool = false

    var filteredItems: [MenuItem] {
        guard let category = selectedCategory else {
            return menuItems
        }
        return menuItems.filter { $0.category == category }
    }

    func loadMenu() async {
        isLoading = true
        // Simulate a short fetch delay
        try? await Task.sleep(nanoseconds: 500_000_000)
        menuItems = MenuItem.sampleItems
        isLoading = false
    }

    func selectCategory(_ category: MenuCategory?) {
        selectedCategory = category
    }
}
