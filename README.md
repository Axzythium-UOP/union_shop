# Union Shop — Flutter E-Commerce Application

A fully functional Flutter e-commerce application showcasing the University of Portsmouth Student Union's online store. Built with Flutter for web and mobile platforms, featuring a complete shopping experience with product browsing, shopping cart management, and authentication UI.

## 🎯 Key Features

- **🏠 Homepage**: Dynamic product grid with featured collections
- **🛍️ Product Catalog**: Browse all products with detailed product pages
- **🏬 Collections**: Organized product collections with filtering
- **🛒 Shopping Cart**: Full cart management with quantity controls and real-time price calculations
- **👤 User Authentication**: Authentication page with login/signup forms
- **ℹ️ About Us**: Company information and mission statement
- **📱 Responsive Design**: Optimized for mobile and web viewing
- **🎨 Material Design**: Modern UI with custom theme colors
- **⚡ State Management**: Provider pattern for efficient state management
- **✅ Comprehensive Testing**: 190+ widget tests ensuring code quality

## 📋 Prerequisites

Before you begin, ensure you have the following installed on your system:

### **macOS**
```bash
brew install --cask visual-studio-code flutter
```

### **Windows**
Install [Chocolatey](https://chocolatey.org/install), then run:
```bash
choco install git vscode flutter -y
```

### **Linux**
Install Flutter from [flutter.dev](https://flutter.dev/docs/get-started/install/linux)

### **Verify Installation**
```bash
flutter doctor
```

## 🚀 Installation and Setup

### 1. Clone the Repository

```bash
git clone https://github.com/Axzythium-UOP/union_shop.git
cd union_shop
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the Application

#### **For Web (Recommended for Development)**
```bash
flutter run -d chrome
```

This will launch the app in Chrome. Open Chrome DevTools (`F12`) and enable mobile view for the best experience.

#### **For Mobile Emulator**
```bash
# Start emulator first (Android)
flutter emulators --launch <emulator_id>

# Then run the app
flutter run
```

## 💻 Usage Instructions

### **Navigation**

The app uses a bottom navigation bar to switch between screens:

1. **Home** - Browse featured products
2. **Products** - View all available products
3. **Collections** - Browse organized product collections
4. **About Us** - Learn about Union Shop
5. **Account** - Authentication page (login/signup)

### **Shopping Workflow**

1. **Browse Products**: Navigate to the Products or Collections page
2. **View Details**: Tap any product to see full details
3. **Select Options**: Choose size and color from dropdowns
4. **Add to Cart**: Increase quantity and add to shopping cart
5. **View Cart**: Access cart from the bottom navigation or product page
6. **Manage Cart**: Adjust quantities or remove items
7. **Checkout**: Place order (processed without real payment)

### **Running Tests**

Run all tests:
```bash
flutter test
```

Run tests with coverage:
```bash
flutter test --coverage
```

Run specific test file:
```bash
flutter test test/cart_test.dart
```

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point and routing configuration
├── models/
│   └── cart_item.dart          # CartItem data model
├── providers/
│   └── cart_provider.dart      # Cart state management (Provider pattern)
├── views/
│   ├── home_page.dart          # Homepage with product grid
│   ├── product_page.dart       # Individual product detail page
│   ├── products_page.dart      # Product catalog page
│   ├── cart.dart               # Shopping cart screen
│   ├── collections.dart        # Collections browsing page
│   ├── about_us.dart           # About Us information page
│   └── authentication_page.dart # Login/signup authentication page
├── widgets/
│   └── widgets.dart            # Reusable UI components (CustomHeader, FooterWidget)
└── repositorties/              # Repository layer for data access

test/
├── home_test.dart              # Homepage widget tests (30+ tests)
├── cart_test.dart              # Cart functionality tests (44 tests)
├── product_test.dart           # Product page tests (31 tests)
├── widgets_test.dart           # Custom widget tests (30+ tests)
├── authentication_test.dart    # Authentication page tests (26 tests)
├── about_us_test.dart          # About Us page tests (10 tests)
├── collections_test.dart       # Collections page tests (28 tests)
└── products_page_test.dart     # Products page tests (33 tests)

assets/
└── images/                     # Product images and assets
```

## 🔧 Technologies & Dependencies

### **Framework & Language**
- **Flutter**: 3.x
- **Dart**: 2.17+

### **Key Dependencies**
- **provider**: ^6.0.5 - State management using the Provider pattern
- **flutter_test**: Testing framework with widget testing capabilities
- **cupertino_icons**: iOS-style icons
- **material_design_icons**: Material Design icons for UI

### **Development Tools**
- **Visual Studio Code**: Code editor with Flutter extension
- **Chrome DevTools**: For web development and debugging
- **Android Studio Emulator** (optional): For mobile testing

## ✨ Features in Detail

### **1. Shopping Cart System**
- Add/remove items with multiple variants (size, color)
- Increment/decrement quantities
- Real-time price calculations
- Cart persistence (managed by CartProvider)
- Empty cart handling
- Item deduplication (combining same items with different quantities)

### **2. Product Pages**
- Product images with error handling
- Size and color selection dropdowns
- Quantity selector with +/- buttons
- Price display with currency formatting (GBP £)
- Add to cart functionality
- Product details display

### **3. Collections**
- Organized product groupings
- Product filtering and browsing
- Navigation between collections
- Asset-based product images

### **4. Authentication UI**
- Login form with email/password fields
- Signup form (UI only)
- Input validation display
- Error message handling
- Form state management

### **5. Responsive Design**
- Mobile-first approach
- Adaptive layouts for different screen sizes
- Touch-friendly button sizes
- Proper spacing and padding
- Optimized for web and mobile

## 🧪 Testing

The project includes **190+ comprehensive widget tests** covering:

- ✅ Cart operations (add, remove, quantity management)
- ✅ Product page interactions
- ✅ Navigation between screens
- ✅ UI component rendering
- ✅ Form input handling
- ✅ State management with Provider
- ✅ Image loading and error handling
- ✅ Price calculations and formatting

**Test Coverage**: ~85% of application code

Run tests with detailed output:
```bash
flutter test --verbose
```

## 🐛 Known Issues & Limitations

### **Current Limitations**
- Authentication is UI-only; backend integration not implemented
- Network images return 400 errors in test environment (expected behavior)
- No real payment processing
- Cart data not persisted across app sessions
- Search functionality not yet implemented
- No real-time inventory management

### **Future Improvements**
- [ ] Firebase Authentication integration
- [ ] Backend API integration for dynamic product data
- [ ] Firestore database for order persistence
- [ ] Payment gateway integration (Stripe/PayPal)
- [ ] Search functionality
- [ ] User profile and order history
- [ ] Product reviews and ratings
- [ ] Wishlist feature
- [ ] Email notifications
- [ ] Desktop app export

## 📝 Code Quality

- ✅ All code properly formatted with `dart format`
- ✅ No warnings or errors (verified with `flutter analyze`)
- ✅ Follows Dart/Flutter best practices
- ✅ Consistent naming conventions
- ✅ Well-documented code with comments
- ✅ DRY principle applied throughout
- ✅ Provider pattern for scalable state management

## 🤝 Contributing

This is a coursework project for the University of Portsmouth. While the repository is public, contributions from external sources are not accepted.

## 📞 Contact & Support

**Developer**: Dan Gardner => UP2306067@myport.ac.uk
**Course**: Programming Applications and Programming Languages (M30235)  
**University**: University of Portsmouth



## 📜 License

This project is part of University of Portsmouth coursework and is provided as-is for educational purposes.

---


