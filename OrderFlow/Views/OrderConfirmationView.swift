import SwiftUI

struct OrderConfirmationView: View {
    let order: Order
    @ObservedObject var cartViewModel: CartViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var showCheckmark = false

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                Spacer().frame(height: 24)

                // Success animation
                ZStack {
                    Circle()
                        .fill(Color.green.opacity(0.15))
                        .frame(width: 120, height: 120)

                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 72))
                        .foregroundColor(.green)
                        .scaleEffect(showCheckmark ? 1.0 : 0.1)
                        .animation(.spring(response: 0.5, dampingFraction: 0.6), value: showCheckmark)
                }
                .accessibilityIdentifier("confirmation_checkmark_icon")

                // Confirmation message
                VStack(spacing: 8) {
                    Text("Order Placed!")
                        .font(.title)
                        .fontWeight(.bold)
                        .accessibilityIdentifier("confirmation_title_label")

                    Text("Your order is being prepared and will be ready shortly.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .accessibilityIdentifier("confirmation_message_label")
                }

                // Order number card
                VStack(spacing: 12) {
                    Text("Order Number")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .textCase(.uppercase)
                        .accessibilityIdentifier("confirmation_order_number_title")

                    Text(order.id)
                        .font(.system(.title2, design: .monospaced))
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                        .accessibilityIdentifier("confirmation_order_number_label")
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .padding(.horizontal, 24)

                // Order summary
                VStack(alignment: .leading, spacing: 12) {
                    Text("Order Summary")
                        .font(.headline)
                        .accessibilityIdentifier("confirmation_summary_title")

                    ForEach(order.items) { cartItem in
                        HStack {
                            Text("\(cartItem.quantity)x \(cartItem.menuItem.name)")
                                .foregroundColor(.primary)
                                .accessibilityIdentifier("confirmation_summary_item_\(cartItem.menuItem.id)")
                            Spacer()
                            Text(cartItem.formattedSubtotal)
                                .foregroundColor(.secondary)
                                .accessibilityIdentifier("confirmation_summary_item_price_\(cartItem.menuItem.id)")
                        }
                        .font(.subheadline)
                    }

                    Divider()

                    HStack {
                        Text("Total Paid")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(order.formattedTotal)
                            .fontWeight(.bold)
                            .accessibilityIdentifier("confirmation_total_label")
                    }

                    Text("Placed on \(order.formattedDate)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .accessibilityIdentifier("confirmation_date_label")
                }
                .padding(20)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
                .padding(.horizontal, 24)

                // Done button
                Button {
                    cartViewModel.clearOrder()
                    dismiss()
                } label: {
                    Text("Done")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.orange)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                .accessibilityIdentifier("confirmation_done_button")

                Spacer().frame(height: 24)
            }
        }
        .onAppear {
            showCheckmark = true
        }
    }
}
