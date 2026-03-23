import Foundation

struct Order: Identifiable {
    let id: String
    let items: [CartItem]
    let placedAt: Date
    let total: Double

    var formattedTotal: String {
        String(format: "$%.2f", total)
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: placedAt)
    }

    static func generateOrderNumber() -> String {
        let number = Int.random(in: 100000...999999)
        return "ORD-\(number)"
    }
}
