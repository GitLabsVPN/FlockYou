import Foundation

class FlockMACDatabase {
    static let shared = FlockMACDatabase()
    var patterns: [String] = []
    
    private init() {
        loadFromGitHub()
    }
    
    func loadFromGitHub() {
        guard let url = URL(string: "https://raw.githubusercontent.com/yourusername/FlockYou/main/FlockMACDatabase.plist") else {
            print("Invalid URL for Flock database")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching MAC database: $error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = PropertyListDecoder()
                    let macs = try decoder.decode([String].self, from: data)
                    self.patterns = macs
                    
                    DispatchQueue.main.async {
                        print("FlockYou database updated with $macs.count) patterns")
                    }
                } catch {
                    print("Could not parse MAC database: $error.localizedDescription)")
                }
            }
        }.resume()
    }

    func isFlockCamera(macAddress: String) -> Bool {
        return self.patterns.contains(macAddress)
    }
}
