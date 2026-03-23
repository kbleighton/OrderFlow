import Foundation

struct CartItem: Identifiable, Equatable {
    let id: UUID
    let menuItem: MenuItem
    var quantity: Int

    init(menuItem: MenuItem, quantity: Int = 1) {
        self.id = UUID()
        self.menuItem = menuItem
        self.quantity = quantity
    }

    var subtotal: Double {
        menuItem.price * Double(quantity)
    }

    var formattedSubtotal: String {
        String(format: "$%.2f", subtotal)
    }
}
