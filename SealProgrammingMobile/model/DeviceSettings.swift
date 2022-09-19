import Foundation

class DeviceSettings : ObservableObject{
    let userDefaults = UserDefaults.standard
    
    // 最後に接続したペリフェラルのUUID
    @Published var lastUUID: String? {
        didSet {
            userDefaults.set(lastUUID, forKey: "last_uuid")
        }
    }

    init() {
        lastUUID = userDefaults.string(forKey: "last_uuid")
    }
}
