import CoreBluetooth

struct CommandWriter{
    static func write(peripheral: CBPeripheral, characteristic: CBCharacteristic, commands: String){
        // 転送中LED点灯
        writeStrring(peripheral: peripheral, characteristic: characteristic, command: SerialCommand.ledRed100)
        
        // クリア
        writeStrring(peripheral: peripheral, characteristic: characteristic, command: SerialCommand.clear)
        
        // 点滅
        writeStrring(peripheral: peripheral, characteristic: characteristic, command: SerialCommand.blink)
        
        // 位置文字ずつ送信
        for command in commands {
            writeStrring(peripheral: peripheral, characteristic: characteristic, command: String(command))
        }
        
        // ゴール
        writeStrring(peripheral: peripheral, characteristic: characteristic, command: SerialCommand.goal)
        
        // 転送中LED消灯
        writeStrring(peripheral: peripheral, characteristic: characteristic, command: SerialCommand.ledRed0)
    }
    
    private static func writeStrring(peripheral: CBPeripheral, characteristic: CBCharacteristic, command: String){
        let data = command.data(using: .utf8)!
        peripheral.writeValue(data , for: characteristic, type: .withResponse)
    }
}
