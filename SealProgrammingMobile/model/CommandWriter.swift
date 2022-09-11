import CoreBluetooth

struct CommandWriter{
    static func write(peripheral: CBPeripheral, characteristic: CBCharacteristic, commands: String){
        let data = commands.data(using: .utf8)!
        peripheral.writeValue(data , for: characteristic, type: .withResponse)
    }
}
