enum Seal{
    case forward
    case back
    case left
    case right
    case stop
    case light
    case horn
    
    var label: String {
        switch self {
        case .forward: return "forward"
        case .back: return "back"
        case .left: return "left"
        case .right: return "right"
        case .stop: return "stop"
        case .light: return "light"
        case .horn: return "horn"
        }
    }
    
    var text: String {
        switch self {
        case .forward: return "まえ"
        case .back: return "うしろ"
        case .left: return "ひだり"
        case .right: return "みぎ"
        case .stop: return "とまる"
        case .light: return "ライト"
        case .horn: return "クラクション"
        }
    }
    
    var color: Int {
        switch self {
        case .forward: return 0xFF489409
        case .back: return 0xFFD73875
        case .left: return 0xFF278EC2
        case .right: return 0xFF987DAC
        case .stop: return 0xFFEE5505
        case .light: return 0xFFF3C309
        case .horn: return 0xFFA1CB2A
        }
    }
}
