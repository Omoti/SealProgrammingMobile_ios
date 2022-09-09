import CoreBluetooth

class DeviceManager: NSObject, ObservableObject, CBCentralManagerDelegate {
    @Published var isSearching: Bool = false
    @Published var foundPeripherals: [Peripheral] = []
    
    private var centralManager: CBCentralManager!
    
    func startScan() {
        foundPeripherals.removeAll()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        isSearching = true
    }
    
    func stopScan(){
        //disconnectPeripheral()
        centralManager?.stopScan()
        print("# Stop Scan")
        isSearching = false
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager){
        guard central.state == .poweredOn else { return }
        
        // Start advertising this device as a peripheral
        let scanOption = [CBCentralManagerScanOptionAllowDuplicatesKey: true]
        centralManager?.scanForPeripherals(withServices: nil, options: scanOption)
        print("# Start Scan")
        isSearching = true
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber){
    
        if RSSI.intValue >= 0 { return }
        
        let peripheralName = advertisementData[CBAdvertisementDataLocalNameKey] as? String ?? nil
        var _name = "NoName"
        
        if peripheralName != nil {
            _name = String(peripheralName!)
        } else if peripheral.name != nil {
            _name = String(peripheral.name!)
        }
        
        let foundPeripheral: Peripheral = Peripheral(name: _name,
                                                     rssi: RSSI.intValue,
                                                     uuid: peripheral.identifier.uuidString,
                                                     discoverCount: 0)
        
        // 50回に一回検出
        if let index = foundPeripherals.firstIndex(where: { $0.uuid == peripheral.identifier.uuidString }) {
            if foundPeripherals[index].discoverCount % 50 == 0 {
                foundPeripherals[index].name = _name
                foundPeripherals[index].rssi = RSSI.intValue
                foundPeripherals[index].discoverCount += 1
            } else {
                foundPeripherals[index].discoverCount += 1
            }
        } else {
            print(peripheral)
            foundPeripherals.append(foundPeripheral)
        }
    }
}
