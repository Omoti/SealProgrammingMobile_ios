extension Seal{
    var command: String {
        switch(self){
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
}
