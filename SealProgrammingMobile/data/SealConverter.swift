import TensorFlowLiteTaskVision

struct SealConverter{
    static func sealToCommand(seal: Seal) -> String{
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
    
    static func labelToSeal(label: String) -> Seal{
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
    
    static func detectionsToCommands(detactions: [Detection]) -> String{
        var commands = ""
        
        for detection in detactions {
            let label = detection.categories.first?.label ?? ""
            let seal = labelToSeal(label: label)
            commands.append(sealToCommand(seal: seal))
        }
        
        return commands
    }
}
