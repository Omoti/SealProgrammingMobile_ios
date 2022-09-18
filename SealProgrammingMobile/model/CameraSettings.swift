import Foundation

class CameraSettings : ObservableObject{
    let userDefaults = UserDefaults.standard
        
    @Published var showScore: Bool {
            didSet {
                userDefaults.set(showScore, forKey: "show_score")
            }
        }

    init() {
        userDefaults.register(defaults: ["show_score" : false])
        
        showScore = userDefaults.bool(forKey: "show_score")
    }
}
