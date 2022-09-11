struct SealConverter{
    static func SealToCommand(seal: Seal) -> String{
        switch(seal){
        case .forward:
            return SerialCommand.forward
        case .back:
            return SerialCommand.back
        case .left:
            return SerialCommand.left
        case .right:
            return SerialCommand.right
        case .stop:
            return SerialCommand.blink // 停止の代わりに点滅
        case .light:
            return SerialCommand.light
        case .horn:
            return SerialCommand.horn
        }
    }
    
    static func LabelToSeal(label: String) -> Seal{
        switch(label){
        case "forward":
            return Seal.forward
        case "back":
            return Seal.back
        case "left":
            return Seal.left
        case "right":
            return Seal.right
        case "stop":
            return Seal.stop
        case "light":
            return Seal.light
        case "horn":
            return Seal.horn
        default:
            return Seal.stop
        }
    }
}
