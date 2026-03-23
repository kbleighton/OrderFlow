import SwiftUI

struct HomeView: View {
    @ObservedObject var menuViewModel: MenuViewModel
    @ObservedObject var cartViewModel: CartViewModel
    @ObservedObject var authViewModel: AuthViewModel

    @State private var showingCart = false
    @State private var showingSettings = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Category Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        CategoryPill(
                            title: "All",
                            isSelected: menuViewModel.selectedCategory == nil
                        ) {
                            menuViewModel.selectCategory(nil)
                        }
                        .accessibilityIdentifier("category_filter_all")

                        ForEach(MenuCategory.allCases, id: \.self) { category in
                            CategoryPill(
                                title: category.rawValue,
                                isSelected: menuViewModel.selectedCategory == category
                            ) {
                                menuViewModel.selectCategory(category)
                            }
                            .accessibilityIdentifier("category_filter_\(category.rawValue.lowercased())")
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                }
                .accessibilityIdentifier("home_category_scroll_view")

                Divider()

                // Menu List
                if menuViewModel.isLoading {
                    Spacer()
                    ProgressView("Loading menu...")
                        .accessibilityIdentifier("home_loading_indicator")
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(menuViewModel.filteredItems) { item in
                                NavigationLink(destination: MenuItemDetailView(
                                    menuItem: item,
                                    cartViewModel: cartViewModel
                                )) {
                                    MenuItemRow(item: item)
                                }
                                .accessibilityIdentifier("menu_item_row_\(item.id)")
                            }
                        }
                        .padding(16)
                    }
                    .accessibilityIdentifier("home_menu_scroll_view")
                }
            }
            .navigationTitle("OrderFlow")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingSettings = true
                    } label: {
                        Image(systemName: "gear")
                    }
                    .accessibilityIdentifier("home_settings_button")
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingCart = true
                    } label: {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "cart.fill")
                            if cartViewModel.totalItemCount > 0 {
                                Text("\(cartViewModel.totalItemCount)")
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(4)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 8, y: -8)
                                    .accessibilityIdentifier("cart_badge_count")
                            }
                        }
                    }
                    .accessibilityIdentifier("home_cart_button")
                }
            }
            .sheet(isPresented: $showingCart) {
                CartView(cartViewModel: cartViewModel)
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView(authViewModel: authViewModel)
            }
            .task {
                await menuViewModel.loadMenu()
            }
        }
    }
}

struct CategoryPill: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.orange : Color(.systemGray5))
                .cornerRadius(20)
        }
    }
}

struct MenuItemRow: View {
    let item: MenuItem

    var body: some View {
        HStack(spacing: 14) {
            // Image placeholder
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemGray5))
                .frame(width: 80, height: 80)
                .overlay(
                    Image(systemName: categoryIcon(for: item.category))
                        .font(.title2)
                        .foregroundColor(.secondary)
                )
                .accessibilityIdentifier("menu_item_image_\(item.id)")

            VStack(alignment: .leading, spacing: 6) {
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibilityIdentifier("menu_item_name_\(item.id)")

                Text(item.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .accessibilityIdentifier("menu_item_description_\(item.id)")

                Text(item.formattedPrice)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.orange)
                    .accessibilityIdentifier("menu_item_price_\(item.id)")
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(14)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.06), radius: 4, x: 0, y: 2)
    }

    private func categoryIcon(for category: MenuCategory) -> String {
        switch category {
        case .burgers: return "fork.knife"
        case .sides: return "leaf.fill"
        case .drinks: return "cup.and.saucer.fill"
        case .desserts: return "birthday.cake.fill"
        }
    }
}
