import SwiftUI

struct MenuItemDetailView: View {
    let menuItem: MenuItem
    @ObservedObject var cartViewModel: CartViewModel

    @Environment(\.dismiss) private var dismiss
    @State private var showAddedConfirmation = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Hero image placeholder
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color(.systemGray5))
                    .frame(maxWidth: .infinity)
                    .frame(height: 240)
                    .overlay(
                        VStack {
                            Image(systemName: "photo")
                                .font(.system(size: 48))
                                .foregroundColor(.secondary)
                            Text(menuItem.name)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    )
                    .accessibilityIdentifier("detail_item_image")

                VStack(alignment: .leading, spacing: 16) {
                    // Name & Price
                    HStack(alignment: .top) {
                        Text(menuItem.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .accessibilityIdentifier("detail_item_name_label")

                        Spacer()

                        Text(menuItem.formattedPrice)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                            .accessibilityIdentifier("detail_item_price_label")
                    }

                    // Category badge
                    Text(menuItem.category.rawValue)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.orange.opacity(0.15))
                        .cornerRadius(8)
                        .accessibilityIdentifier("detail_item_category_label")

                    Divider()

                    // Description
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description")
                            .font(.headline)
                        Text(menuItem.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                            .accessibilityIdentifier("detail_item_description_label")
                    }

                    Divider()

                    // Allergen note (static demo content)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Allergen Info")
                            .font(.headline)
                        Text("Contains: gluten, dairy. May contain traces of nuts. Please inform our staff of any allergies.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .accessibilityIdentifier("detail_allergen_info_label")
                    }
                }
                .padding(20)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 0) {
                Divider()
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Price")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(menuItem.formattedPrice)
                            .font(.headline)
                            .fontWeight(.bold)
                    }

                    Spacer()

                    Button {
                        cartViewModel.addItem(menuItem)
                        showAddedConfirmation = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            showAddedConfirmation = false
                        }
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: showAddedConfirmation ? "checkmark" : "cart.badge.plus")
                            Text(showAddedConfirmation ? "Added!" : "Add to Order")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 14)
                        .background(showAddedConfirmation ? Color.green : Color.orange)
                        .cornerRadius(12)
                        .animation(.easeInOut(duration: 0.2), value: showAddedConfirmation)
                    }
                    .accessibilityIdentifier("detail_add_to_order_button")
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(Color(.systemBackground))
            }
        }
    }
}
