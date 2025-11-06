# Be Casual - E-Commerce Mobile Application

Be Casual is a modern e-commerce mobile application built with Flutter, focusing on providing a seamless shopping experience for casual wear and accessories.

## 🚀 Features

- **User Authentication**: Complete authentication system for user management
- **Product Catalog**: Browse through various categories and brands
- **Shopping Cart**: Add/remove items and manage your shopping cart
- **Address Management**: Save and manage multiple delivery addresses
- **Order Management**: Track and manage your orders
- **Banner System**: Dynamic banner system for promotions
- **Responsive Design**: Works seamlessly across different screen sizes

## 📱 Tech Stack

- **Framework**: Flutter (SDK ^3.7.2)
- **State Management**: GetX (^4.6.6)
- **UI Components**:
  - Carousel Slider for banner displays
  - Flutter Vector Icons for consistent iconography
  - Easy Stepper (^0.8.3) for multi-step processes
- **Network**: Dio (^5.8.0+1) for API communications
- **Local Storage**: Shared Preferences (^2.5.3)

## 📁 Project Structure

```
lib/
├── common/           # Common widgets and UI components
├── controller/       # GetX controllers for state management
├── model/           # Data models
├── presentation/    # UI screens and components
├── services/        # API and backend services
└── main.dart        # Application entry point
```

## 🏗️ Architecture

The project follows a clean architecture pattern with:
- **MVC+S Pattern**: Model-View-Controller + Service layer
- **GetX State Management**: For reactive state management and dependency injection
- **Modular Structure**: Separated concerns for better maintainability

## 🛠️ Setup and Installation

1. **Prerequisites**:
   - Flutter SDK (^3.7.2)
   - Dart SDK
   - Android Studio / VS Code with Flutter plugins

2. **Installation**:
   ```bash
   # Clone the repository
   git clone https://github.com/Reecorder/Be-Casual.git

   # Navigate to project directory
   cd Be-Casual

   # Install dependencies
   flutter pub get

   # Run the app
   flutter run
   ```

## 📱 Supported Platforms

- Android
- iOS
- Web
- Linux
- macOS
- Windows

## 🔐 Environment Setup

The application is configured to work with different environments:
- Development
- Staging
- Production

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is proprietary and not open for public use without permission.

## 👥 Team

- **Owner**: Reecorder
- **Current Branch**: main

## 📦 Dependencies

- `get: ^4.6.6` - State management
- `carousel_slider` - For image sliders
- `flutter_vector_icons: ^2.0.0` - Icon pack
- `easy_stepper: ^0.8.3` - Multi-step forms
- `dio: ^5.8.0+1` - HTTP client
- `shared_preferences: ^2.5.3` - Local storage

---

⚡️ Developed with Flutter by Reecorder
