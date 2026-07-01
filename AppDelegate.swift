import UIKit
import CoreBluetooth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var centralManager: CBCentralManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ContentView()
        window?.makeKeyAndVisible()
        
        // Initialize Bluetooth manager
        centralManager = CBCentralManager(delegate: self, options: nil)
        
        // Request notification permissions (for alerts)
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Failed to request notifications: $error.localizedDescription)")
            }
        }
        
        return true
    }

    // MARK: - CoreBluetooth Delegate
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Bluetooth state updated: $central.state)")
        if central.state == .poweredOn {
            print("Bluetooth enabled. Starting scan.")
            central.scanForPeripherals(options: nil)
        }
    }
}

extension AppDelegate: CBCentralManagerDelegate {
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi: NSNumber) {
        if let macAddress = peripheral.identifier.uuidString {
            if FlockCameraScanner.shared.isFlockCamera(macAddress: macAddress) {
                DispatchQueue.main.async {
                    FlockCameraScanner.shared.foundCameras.append(macAddress)
                }
            }
        }
    }
}
