import Foundation

struct MenuItem: Identifiable, Equatable {
    let id: String
    let name: String
    let description: String
    let price: Double
    let category: MenuCategory
    let imageName: String

    var formattedPrice: String {
        String(format: "$%.2f", price)
    }
}

enum MenuCategory: String, CaseIterable {
    case burgers = "Burgers"
    case sides = "Sides"
    case drinks = "Drinks"
    case desserts = "Desserts"
}

extension MenuItem {
    static let sampleItems: [MenuItem] = [
        MenuItem(
            id: "item-001",
            name: "Classic Burger",
            description: "A juicy beef patty with lettuce, tomato, onion, and our signature sauce on a toasted brioche bun.",
            price: 12.99,
            category: .burgers,
            imageName: "burger_classic"
        ),
        MenuItem(
            id: "item-002",
            name: "Double Smash Burger",
            description: "Two smashed beef patties, American cheese, pickles, and special smash sauce.",
            price: 15.99,
            category: .burgers,
            imageName: "burger_smash"
        ),
        MenuItem(
            id: "item-003",
            name: "BBQ Bacon Burger",
            description: "Beef patty topped with crispy bacon, cheddar cheese, BBQ sauce, and crispy onion rings.",
            price: 14.99,
            category: .burgers,
            imageName: "burger_bbq"
        ),
        MenuItem(
            id: "item-004",
            name: "Crispy Chicken Sandwich",
            description: "Crispy fried chicken breast with coleslaw, pickles, and honey mustard on a potato bun.",
            price: 13.49,
            category: .burgers,
            imageName: "chicken_sandwich"
        ),
        MenuItem(
            id: "item-005",
            name: "Seasoned Fries",
            description: "Golden crispy fries seasoned with our house blend of spices.",
            price: 4.99,
            category: .sides,
            imageName: "fries"
        ),
        MenuItem(
            id: "item-006",
            name: "Onion Rings",
            description: "Beer-battered onion rings served with ranch dipping sauce.",
            price: 5.99,
            category: .sides,
            imageName: "onion_rings"
        ),
        MenuItem(
            id: "item-007",
            name: "Chocolate Milkshake",
            description: "Thick and creamy chocolate milkshake made with premium ice cream.",
            price: 6.99,
            category: .drinks,
            imageName: "milkshake_chocolate"
        ),
        MenuItem(
            id: "item-008",
            name: "Lemonade",
            description: "Fresh-squeezed lemonade with a hint of mint.",
            price: 3.99,
            category: .drinks,
            imageName: "lemonade"
        ),
        MenuItem(
            id: "item-009",
            name: "Chocolate Brownie",
            description: "Warm fudge brownie served with a scoop of vanilla ice cream.",
            price: 7.49,
            category: .desserts,
            imageName: "brownie"
        ),
        MenuItem(
            id: "item-010",
            name: "Apple Pie",
            description: "Classic apple pie with cinnamon and a flaky golden crust.",
            price: 5.49,
            category: .desserts,
            imageName: "apple_pie"
        )
    ]
}
