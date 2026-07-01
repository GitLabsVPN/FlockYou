import Foundation

class FlockCameraScanner {
    static let shared = FlockCameraScanner()
    
    @Published var foundCameras: [String] = []
    
    func isFlockCamera(macAddress: String) -> Bool {
        let database = FlockMACDatabase()
        return database.isFlockCamera(macAddress: macAddress)
    }
}
