import SwiftUI
import CoreBluetooth
import Foundation
import UserNotifications

struct ContentView: View {
    @State private var bluetoothScanning = false
    @State private var foundCameras: [String] = []
    @State private var showKeychainStorage = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                // Dynamic background based on dark/light mode
                Color(UISceneAppearance.current.backgroundColor)
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 20) {
                    Text("🎥 FlockYou")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding()

                    // Toggle for Bluetooth scanning (modified for modern look)
                    Toggle(isOn: $bluetoothScanning) {
                        Text("Enable Bluetooth Scanning")
                            .foregroundColor(.primary)
                    }
                    .onChange(of: bluetoothScanning) { newValue in
                        if newValue {
                            FlockCameraScanner.shared.startScan()
                        } else {
                            FlockCameraScanner.shared.stopScan()
                        }
                    }

                    HStack {
                        Button("Start Scanning") {
                            bluetoothScanning = true
                        }
                        .disabled(!bluetoothScanning)
                        .padding(.trailing)
                        .buttonStyle(.bordered)
                        .foregroundColor(.blue)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)

                        Button("Stop Scanning") {
                            bluetoothScanning = false
                        }
                        .buttonStyle(.bordered)
                        .foregroundColor(.blue)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }

                    if !foundCameras.isEmpty {
                        Text("🔍 Found Potential Flock Cameras:")
                            .font(.title)
                            .foregroundColor(.blue)
                    } else {
                        Text("No cameras found yet.")
                            .foregroundColor(Color.secondary)
                    }

                    if !foundCameras.isEmpty {
                        List(foundCameras, id: \.self) { mac in
                            HStack {
                                Text(mac)
                                    .foregroundColor(.blue)
                                Spacer()
                            }
                        }
                        .listStyle(.inset)
                    } else {
                        Text("No results found yet.")
                    }

                    NavigationLink(destination: SecureStorageView()) {
                        Text("🔑 Secure Storage (FlockYou Keychain)")
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }

                    // Show alert if FlockYou detects a camera
                    if showAlert {
                        Alert(title: Text("🚨 FlockYou Alert"),
                              message: Text(alertMessage),
                              dismissButton: .default(Text("OK")))
                    }
                }

                // Bluetooth not enabled message
                if centralManager.state == .notDetermined {
                    Text("Bluetooth is not enabled. Please enable Bluetooth to proceed.")
                        .foregroundColor(.red)
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .font(.body)
            .padding()
        }
        .navigationViewStyle(.stack)
    }

    private var centralManager: CBCentralManager {
        get {
            return CBCentralManager.shared
        }
    }
}
