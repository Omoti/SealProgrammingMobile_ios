import CoreBluetooth

class DeviceManager: NSObject, ObservableObject, CBCentralManagerDelegate {
    @Published var isSearching: Bool = false
    
    private var centralManager: CBCentralManager!
    
    func startScan() {
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
        print(peripheral)
    }
}

