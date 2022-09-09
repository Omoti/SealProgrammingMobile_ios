import CoreBluetooth
import CoreVideo

class DeviceManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    @Published var isSearching: Bool = false
    @Published var foundPeripherals: [Peripheral] = []
    
    private var centralManager: CBCentralManager!
    private var currentPeripheral: CBPeripheral? = nil
    private let serviceUUID: [CBUUID] = [CBUUID(string: "6E400001-B5A3-F393-E0A9-E50E24DCCA9E")]
    private let characteristicUUID: [CBUUID] = [CBUUID(string: "6E400002-B5A3-F393-E0A9-E50E24DCCA9E")] //RX
    
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
    
    func connect(peripheral: Peripheral){
        currentPeripheral = peripheral.peripheral
        centralManager.connect(currentPeripheral!)
        stopScan()
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
                                                     discoverCount: 0,
                                                     peripheral: peripheral)
        
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
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if(currentPeripheral == nil) {return}
        
        currentPeripheral!.delegate = self
        currentPeripheral!.discoverServices(serviceUUID)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print(error!)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if(error == nil){
            print("found service")
        }
        else{
            print(error!)
        }
    }
}
