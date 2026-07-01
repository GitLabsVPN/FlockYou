import SwiftUI

struct SecureStorageView: View {
    @State private var cameraMACs: [String] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Text("🔑 Secure Storage for Flock Cameras")
                    .font(.largeTitle)
                    .padding()
                
                if !cameraMACs.isEmpty {
                    Text("Stored Flock Cameras:")
                        .font(.title)
                    List(cameraMACs) { mac in
                        Text(mac)
                    }
                } else {
                    Text("No stored cameras yet.")
                }
                
                Button("Save to Keychain") {
                    KeychainManager.shared.saveCameraMAC(mac: "Flock-78:8D:71")
                }
                
                Button("Load from Keychain") {
                    cameraMACs = KeychainManager.shared.getStoredCameraMACs()
                }
                
                Button("Delete Stored MAC") {
                    KeychainManager.shared.deleteCameraMAC(mac: "Flock-78:8D:71")
                }
            }
            .padding()
        }
    }
}
