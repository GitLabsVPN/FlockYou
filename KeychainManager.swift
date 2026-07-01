import Foundation
import KeychainServices

class KeychainManager {
    static let shared = KeychainManager()
    private let keychain = KeychainService()
    
    func saveCameraMAC(mac: String) {
        do {
            try keychain.save(encryptedMAC: encrypt(mac: mac))
        } catch {
            print("Failed to save MAC to Keychain: $error.localizedDescription)")
        }
    }

    func getStoredMACs() -> [String] {
        do {
            return try keychain.load()
        } catch {
            print("Failed to retrieve MACs from Keychain: $error.localizedDescription)")
            return []
        }
    }

    func deleteCameraMAC(mac: String) {
        do {
            try keychain.delete(encryptedMAC: encrypt(mac: mac))
        } catch {
            print("Failed to delete MAC from Keychain: $error.localizedDescription)")
        }
    }
}

class KeychainService {
    // Encrypts MAC addresses using simple XOR for demo purposes
    func encrypt(mac: String) -> String {
        guard let key = "flockyou" else { return "" }
        var encryptedData = ""
        
        for c in mac {
            let keyIndex = key.firstIndex(of: c)!
            encryptedData.append(c ^ keyIndex)
        }

        return encryptedData
    }

    func decrypt(encryptedData: String) -> String {
        guard let key = "flockyou" else { return "" }
        var decryptedData = ""
        
        for c in encryptedData {
            let keyIndex = key.firstIndex(of: c)!
            decryptedData.append(c ^ keyIndex)
        }

        return decryptedData
    }

    // Save encrypted MAC to Keychain
    func save(_ encryptedMAC: String) throws {
        let query = NSMutableDictionary()
        query.setValue(encryptedMAC, forKey: kSecAttrGenericPassword as String)
        query.setValue("FlockYou", forKey: kSecAttrService as String)
        
        let status = SecItemAdd(query as! NSMutableDictionary, nil)
        if status != errSecSuccess {
            throw NSError(domain: "KeychainError", code: Int(status), userInfo: nil)
        }
    }
    
    // Load encrypted MAC
    func load() throws -> [String] {
        let query = NSMutableDictionary()
        query.setValue("FlockYou", forKey: kSecAttrService as String)
        query.setValue(kSecClassGenericPassword, forKey: kSecClass as String)

        var itemData: AnyObject?
        let status = SecItemCopyMatchingItemData(query as! NSMutableDictionary, &itemData)
        
        if status == errSecSuccess {
            if let data = itemData as? Data {
                if let string = String(data: data, encoding: .utf8) {
                    return [decrypt(encryptedData: string)]
                }
            }
        }
        return []
    }
    
    // Delete encrypted MAC
    func delete(_ encryptedMAC: String) throws {
        let query = NSMutableDictionary()
        query.setValue(encryptedMAC, forKey: kSecAttrGenericPassword as String)
        query.setValue("FlockYou", forKey: kSecAttrService as String)
        query.setValue(kSecClassGenericPassword, forKey: kSecClass as String)
        
        let status = SecItemDelete(query as! NSMutableDictionary)
        if status != errSecSuccess {
            throw NSError(domain: "KeychainError", code: Int(status), userInfo: nil)
        }
    }
}
