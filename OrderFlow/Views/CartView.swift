import SwiftUI

struct CartView: View {
    @ObservedObject var cartViewModel: CartViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Group {
                if cartViewModel.isEmpty && cartViewModel.placedOrder == nil {
                    EmptyCartView()
                } else if let order = cartViewModel.placedOrder {
                    OrderConfirmationView(order: order, cartViewModel: cartViewModel)
                } else {
                    cartItemsList
                }
            }
            .navigationTitle("Your Order")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                    .accessibilityIdentifier("cart_close_button")
                }
            }
        }
    }

    private var cartItemsList: some View {
        VStack(spacing: 0) {
            List {
                ForEach(cartViewModel.items) { cartItem in
                    CartItemRow(
                        cartItem: cartItem,
                        onIncrement: { cartViewModel.incrementQuantity(for: cartItem) },
                        onDecrement: { cartViewModel.decrementQuantity(for: cartItem) },
                        onRemove: { cartViewModel.removeItem(cartItem) }
                    )
                    .accessibilityIdentifier("cart_item_row_\(cartItem.menuItem.id)")
                }
            }
            .listStyle(.plain)
            .accessibilityIdentifier("cart_items_list")

            // Order Summary & Place Order
            VStack(spacing: 0) {
                Divider()
                VStack(spacing: 16) {
                    HStack {
                        Text("Subtotal")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(cartViewModel.formattedTotal)
                            .accessibilityIdentifier("cart_subtotal_label")
                    }

                    HStack {
                        Text("Tax (8%)")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(String(format: "$%.2f", cartViewModel.orderTotal * 0.08))
                            .accessibilityIdentifier("cart_tax_label")
                    }

                    Divider()

                    HStack {
                        Text("Total")
                            .font(.headline)
                        Spacer()
                        Text(String(format: "$%.2f", cartViewModel.orderTotal * 1.08))
                            .font(.headline)
                            .fontWeight(.bold)
                            .accessibilityIdentifier("cart_total_label")
                    }

                    Button {
                        Task {
                            await cartViewModel.placeOrder()
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.orange)
                                .frame(height: 52)

                            if cartViewModel.isPlacingOrder {
                                HStack(spacing: 10) {
                                    ProgressView()
                                        .tint(.white)
                                        .accessibilityIdentifier("cart_placing_order_indicator")
                                    Text("Placing Order...")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                }
                            } else {
                                Text("Place Order")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .font(.headline)
                            }
                        }
                    }
                    .disabled(cartViewModel.isPlacingOrder)
                    .accessibilityIdentifier("cart_place_order_button")
                }
                .padding(20)
                .background(Color(.systemBackground))
            }
        }
    }
}

struct CartItemRow: View {
    let cartItem: CartItem
    let onIncrement: () -> Void
    let onDecrement: () -> Void
    let onRemove: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(cartItem.menuItem.name)
                    .font(.headline)
                    .accessibilityIdentifier("cart_item_name_\(cartItem.menuItem.id)")
                Text(cartItem.menuItem.formattedPrice)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .accessibilityIdentifier("cart_item_unit_price_\(cartItem.menuItem.id)")
            }

            Spacer()

            // Quantity stepper
            HStack(spacing: 0) {
                Button {
                    onDecrement()
                } label: {
                    Image(systemName: cartItem.quantity <= 1 ? "trash" : "minus")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .frame(width: 30, height: 30)
                        .foregroundColor(cartItem.quantity <= 1 ? .red : .primary)
                }
                .accessibilityIdentifier("cart_item_decrement_\(cartItem.menuItem.id)")

                Text("\(cartItem.quantity)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 30)
                    .accessibilityIdentifier("cart_item_quantity_\(cartItem.menuItem.id)")

                Button {
                    onIncrement()
                } label: {
                    Image(systemName: "plus")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.orange)
                }
                .accessibilityIdentifier("cart_item_increment_\(cartItem.menuItem.id)")
            }
            .padding(4)
            .background(Color(.systemGray6))
            .cornerRadius(8)

            Text(cartItem.formattedSubtotal)
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 56, alignment: .trailing)
                .accessibilityIdentifier("cart_item_subtotal_\(cartItem.menuItem.id)")
        }
        .padding(.vertical, 4)
    }
}

struct EmptyCartView: View {
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "cart")
                .font(.system(size: 64))
                .foregroundColor(.secondary)
                .accessibilityIdentifier("cart_empty_icon")
            Text("Your cart is empty")
                .font(.title3)
                .fontWeight(.semibold)
                .accessibilityIdentifier("cart_empty_title_label")
            Text("Browse our menu and add items to get started.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .accessibilityIdentifier("cart_empty_subtitle_label")
            Spacer()
        }
    }
}
