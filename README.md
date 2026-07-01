# FlockYou
**"This app is not to be used for illegal purposes. FlockYou scans for known MAC patterns, not actual cameras."**
**FlockYou** is a **security-first iOS app** that implements **Bluetooth scanning** and **MAC address matching** to help users identify **potential Flock cameras**. It stores all data **locally** using **iOS Keychain** and pulls **updated MAC patterns** from **GitHub** for real-time detection.

---

## 🧾 Features

- 📷 **Bluetooth scanning** using **CoreBluetooth**
- 🔍 **Real-time detection** of **Flock-like MAC addresses**
- 🔒 **Secure storage** via **iOS Keychain**
- 📢 **Push notifications** when a camera is found
- 🌐 **Auto-updated MAC database** from **GitHub**
- 🖼 **Dark Mode** and **modern UI**

---

## 🧠 What is FlockYou?

FlockYou focuses on **detecting unknown or suspicious devices** using MAC address patterns. It's designed to be **user-friendly**, **secure**, and **privacy-focused**.

> ⚠️ It does **not identify cameras with 100% accuracy**. It only **flags potential devices** based on **known MAC patterns**.

---

## 📌 How It Works

1. App starts **Bluetooth scanning**
2. It **matches found MAC addresses** with a **local database**
3. If match is found, app **sends a local on-device alert**
4. MACs can be **saved securely in Keychain**
5. **Auto-updated MAC database** from **GitHub**

---

## 🛡️ Privacy & Security

- 🔒 **All data is kept local** – no cloud, no tracking
- 🧬 **Secure Keychain storage**
- 📧 **Optional notifications** for device alerts
- ⚠️ **"Only for self-testing or with consent"**

---

## 🚀 Requirements

- iOS 14 or later
- Xcode 14 or later
- Keep **FlockMACDatabase.plist** updated on GitHub
- Enable **Bluetooth** in settings

---

## 🧮 Technologies Used

- **Swift / SwiftUI** – for clean and modern UI
- **CoreBluetooth** – to scan devices and extract MAC addresses
- **iOS Keychain** – for secure local storage
- **UserNotifications** – for real-time alerts
- **GitHub** – for **auto-updating MAC list**

---

## 🧠 Architecture

1. **Bluetooth Manager** – handles scanning and device detection
2. **MAC Database** – pulls from GitHub and matches patterns
3. **Secure Storage** – saves MAC addresses to iOS Keychain
4. **Notification Manager** – sends alerts on detection
5. **UI Coordinator** – controls app flow with dark mode support

---

## 🧾 Installation (Steps for Users)

1. Clone the repo:
   ```bash
   git clone https://github.com/GitLabsVPN/FlockYou.git
   cd FlockYou
