# FlockCameraScanner Architecture

## 🧠 Core Concepts

1. **Bluetooth Scanner** – Uses `CBCentralManager` to scan nearby devices
2. **MAC Database** – Loads from a local `.plist` file with known Flock camera MACs
3. **Secure Storage** – Uses iOS Keychain for persistent local storage
4. **UI** – Simple SwiftUI application for user interaction
5. **Notifications** – Uses `UserNotifications` for alerts when Flock patterns are found

## 🧩 Feature Breakdown

| Feature | Description |
|--------|-------------|
| 📷 Bluetooth Scanning | Reveals nearby Bluetooth devices via CoreBluetooth API |
| 🔍 MAC Matching | Checks if a device’s MAC address is found in the Flock database |
| 🔒 Secure Storage | Saves found MACs to iOS Keychain |
| 📢 Notifications | Sends local on-device alerts for suspicious activity |
| 📌 Open Source | MIT License for full transparency and community use |
