import Foundation

class CameraSettings : ObservableObject{
    let userDefaults = UserDefaults.standard
    
    @Published var showScore: Bool {
        didSet {
            userDefaults.set(showScore, forKey: "show_score")
        }
    }
    
    @Published var threshold: Float {
        didSet {
            userDefaults.set(threshold, forKey: "threshold")
        }
    }
    
    init() {
        userDefaults.register(defaults: ["show_score" : false,
                                         "threshold" : 0.4])
        
        showScore = userDefaults.bool(forKey: "show_score")
        threshold = userDefaults.float(forKey: "threshold")
    }
}
