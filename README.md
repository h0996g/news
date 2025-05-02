````markdown
## 🧾 Project Configuration Overview

---

### ✅ Flutter Environment

| 🔧 Component  | 💡 Value                              |
| ------------- | ------------------------------------- |
| Flutter SDK   | 3.29.2 (stable)                       |
| Dart SDK      | >= 3.7.2                              |
| OS            | Windows 11 Pro (64-bit, Version 24H2) |
| IDEs          | Android Studio 2024.2, VS Code 1.99.3 |
| Build Targets | Android, Web, Windows Desktop         |

---

### 🌐 Environment Management

You must **manually add** the following files to the root of the project after cloning:

- `.env.devlopment`
- `.env.production`

These files contain environment-specific variables such as API URLs or keys and are loaded using `flutter_dotenv`.

Example `.env` content:

```env
baseUrl=https://example.com/api
apiKey=your_api_key_here
```



### 🛠 Build & Run Configuration

1. 📦 Install dependencies

   ```bash
   flutter pub get
   ```

2. 🧬 Generate Hive adapters (if needed)

   If you're using Hive for local storage and have models with `@HiveType`, generate adapters with:

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

   Re-run this command anytime you modify your Hive model classes.

3. ▶️ Run the app

   ```bash
   flutter run
   ```

4. 🧹 Clean and rebuild (optional)

   If you encounter build issues:

   ```bash
   flutter clean
   flutter pub get
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

```

```
