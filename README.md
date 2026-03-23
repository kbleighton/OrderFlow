# OrderFlow

A demo iOS app built as a companion project for the **XCUITest Automation Course**. OrderFlow simulates a food ordering experience with multiple screens, realistic async states, and accessibility identifiers pre-wired throughout — everything you need to learn professional XCUITest techniques from the ground up.

---

## Project Overview

OrderFlow is a SwiftUI app targeting iOS 16+. It contains no real backend — all data is hardcoded or mocked locally to keep the focus on UI automation rather than networking.

### Screens

| Screen | Description |
|--------|-------------|
| **Login** | Username/password fields with a simulated async loading state |
| **Home** | Scrollable menu list with category filters |
| **Detail** | Item detail page with an "Add to Order" button |
| **Cart** | Cart sheet with quantity controls, subtotal, and "Place Order" |
| **Order Confirmation** | Success screen with order number after placing an order |
| **Settings** | Toggle-based preferences screen with a logout button |

### Project Structure

```
OrderFlow/
├── OrderFlow/
│   ├── Models/          # MenuItem, CartItem, Order
│   ├── ViewModels/      # AuthViewModel, MenuViewModel, CartViewModel, SettingsViewModel
│   ├── Views/           # All SwiftUI screen files
│   ├── ContentView.swift
│   └── OrderFlowApp.swift
└── OrderFlowUITests/    # Empty XCUITest target — built out during the course
```

### Accessibility Identifiers

All interactive elements and key labels carry `accessibilityIdentifier` values following a consistent `screen_element_type` naming convention. For example:

- `login_username_field`
- `login_password_field`
- `login_button`
- `home_cart_button`
- `detail_add_to_order_button`
- `cart_place_order_button`
- `confirmation_order_number_label`
- `settings_notifications_toggle`

Demo credentials: **username:** `demo` / **password:** `password`

---

## Prerequisites

- **Xcode 15** or later
- **iOS 16** deployment target (simulator or physical device)
- macOS Ventura 13.0 or later

---

## Clone and Open in Xcode

```bash
git clone https://github.com/YOUR_USERNAME/OrderFlow.git
cd OrderFlow
open OrderFlow.xcodeproj
```

Xcode will open the project directly. No additional setup or dependency installation is required.

---

## Run the App

1. Open `OrderFlow.xcodeproj` in Xcode.
2. Select the **OrderFlow** scheme from the scheme picker in the toolbar.
3. Choose a simulator (iPhone 15 recommended) or a connected device.
4. Press **⌘R** (or click the Run button).
5. Log in with `demo` / `password`.

---

## Run the XCUITest Target

The `OrderFlowUITests` target is an empty scaffold ready for you to build out as you work through the course.

### From Xcode

1. Select the **OrderFlowUITests** scheme from the scheme picker.
2. Press **⌘U** to run the test suite (or go to **Product → Test**).
3. Results appear in the Test Navigator (**⌘6**).

### From the Command Line

```bash
xcodebuild test \
  -project OrderFlow.xcodeproj \
  -scheme OrderFlowUITests \
  -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest'
```

To run a specific test class:

```bash
xcodebuild test \
  -project OrderFlow.xcodeproj \
  -scheme OrderFlowUITests \
  -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest' \
  -only-testing:OrderFlowUITests/LoginTests
```

---

## Course Topics Covered Using This App

- **Page Object Model (POM)** architecture for XCUITest
- Handling async UI states (loading spinners, delayed navigation)
- Writing reliable assertions with `waitForExistence`
- Testing navigation flows across multiple screens
- Debugging flaky tests
- Integrating XCUITest into a CI/CD pipeline with GitHub Actions

---

## Contributing

This repo is a course companion. If you spot a bug or want to suggest an improvement, open an issue or pull request.

---

*Built with SwiftUI · iOS 16+ · Xcode 15+*
