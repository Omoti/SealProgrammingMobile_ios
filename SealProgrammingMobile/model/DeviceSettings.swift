import Foundation

class DeviceSettings : ObservableObject{
    let userDefaults = UserDefaults.standard
    
    // 最後に接続したペリフェラルのRSSI
    @Published var lastRssi: String? {
        didSet {
            userDefaults.set(lastRssi, forKey: "last_rssi")
        }
    }

    init() {
        lastRssi = userDefaults.string(forKey: "last_rssi")
    }
}
