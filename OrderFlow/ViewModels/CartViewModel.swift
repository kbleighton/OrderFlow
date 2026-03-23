import Foundation
import Combine

@MainActor
class CartViewModel: ObservableObject {
    @Published var items: [CartItem] = []
    @Published var isPlacingOrder: Bool = false
    @Published var placedOrder: Order? = nil

    var totalItemCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }

    var orderTotal: Double {
        items.reduce(0) { $0 + $1.subtotal }
    }

    var formattedTotal: String {
        String(format: "$%.2f", orderTotal)
    }

    var isEmpty: Bool {
        items.isEmpty
    }

    func addItem(_ menuItem: MenuItem) {
        if let index = items.firstIndex(where: { $0.menuItem.id == menuItem.id }) {
            items[index].quantity += 1
        } else {
            items.append(CartItem(menuItem: menuItem))
        }
    }

    func removeItem(_ cartItem: CartItem) {
        items.removeAll { $0.id == cartItem.id }
    }

    func incrementQuantity(for cartItem: CartItem) {
        guard let index = items.firstIndex(where: { $0.id == cartItem.id }) else { return }
        items[index].quantity += 1
    }

    func decrementQuantity(for cartItem: CartItem) {
        guard let index = items.firstIndex(where: { $0.id == cartItem.id }) else { return }
        if items[index].quantity <= 1 {
            items.remove(at: index)
        } else {
            items[index].quantity -= 1
        }
    }

    func placeOrder() async {
        guard !isEmpty else { return }

        isPlacingOrder = true
        // Simulate order processing delay
        try? await Task.sleep(nanoseconds: 2_000_000_000)

        let order = Order(
            id: Order.generateOrderNumber(),
            items: items,
            placedAt: Date(),
            total: orderTotal
        )

        placedOrder = order
        items = []
        isPlacingOrder = false
    }

    func clearOrder() {
        placedOrder = nil
    }
}
