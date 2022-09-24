import CoreBluetooth
import Combine

class DeviceModel: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    @Published var isSearching: Bool = false
    @Published var foundPeripherals: [Peripheral] = []
    @Published var connectedPeripheral: Peripheral? = nil
    @Published var lastUUID: String? = nil
    
    private let settings = DeviceSettings()
    private var centralManager: CBCentralManager!
    private var currentPeripheral: CBPeripheral? = nil
    private let serviceUUID: [CBUUID] = [CBUUID(string: "6E400001-B5A3-F393-E0A9-E50E24DCCA9E")]
    private let characteristicUUID: [CBUUID] = [CBUUID(string: "6E400002-B5A3-F393-E0A9-E50E24DCCA9E")] //RX
    private var writeData: String = ""
    private var scanTimer :Timer?
    
    private var autoConnect = true
    
    override init() {
        super.init()
        lastUUID = self.settings.lastUUID
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startScan(autoConnect: Bool) {
        print("# Scanning")
        self.autoConnect = autoConnect
        
        foundPeripherals.removeAll()

        if centralManager.state == .poweredOn {
            // 重複を無視する
            let scanOption = [CBCentralManagerScanOptionAllowDuplicatesKey: false]
            centralManager?.scanForPeripherals(withServices: nil, options: scanOption)
            isSearching = true
            
            scanTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { _ in
                print("# fire timer")
                self.stopScan()
            }
        } else {
            print("Cannot Start Scan")
        }
    }

    func stopScan(){
        scanTimer?.invalidate()

        centralManager?.stopScan()
        isSearching = false

        print("# Stop Scan")
    }

    func connect(peripheral: Peripheral){
        currentPeripheral = peripheral.peripheral
        connectedPeripheral = peripheral
        centralManager.connect(currentPeripheral!)
        stopScan()
        
        settings.lastUUID = peripheral.uuid
    }
    
    func disconnect(){
        if let peripheral = connectedPeripheral?.peripheral {
            centralManager.cancelPeripheralConnection(peripheral)
            connectedPeripheral = nil
            settings.lastUUID = nil
            lastUUID = nil
            
            centralManager = CBCentralManager(delegate: self, queue: nil)
        }
    }
    
    func write(data: String){
        let service: CBService? = currentPeripheral?.services?.first
        
        if(service != nil){
            writeData = data
            currentPeripheral!.discoverCharacteristics(characteristicUUID, for: service!)
        }
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager){
        guard central.state == .poweredOn else { return }
                
        startScan(autoConnect: false) // disable auto scan
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber){
        
        if RSSI.intValue >= 0 { return }
        
        let peripheralName = advertisementData[CBAdvertisementDataLocalNameKey] as? String ?? nil
        var _name = "NoName"
        
        if peripheralName == nil {
            return // 名前がないものは無視する
        }else if peripheralName != nil {
            _name = String(peripheralName!)
        } else if peripheral.name != nil {
            _name = String(peripheral.name!)
        }
        
        let foundPeripheral: Peripheral = Peripheral(name: _name,
                                                     rssi: RSSI.intValue,
                                                     uuid: peripheral.identifier.uuidString,
                                                     peripheral: peripheral)
        
        foundPeripherals.append(foundPeripheral)
        print("found peripheral:" + _name)
        
        // 自動接続
        if autoConnect {
            if foundPeripheral.uuid == lastUUID && connectedPeripheral == nil {
                connect(peripheral: foundPeripheral)
            }
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
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        for i in service.characteristics!{
            switch(i.uuid.uuidString){
            case characteristicUUID.first?.uuidString:
                print("write:" + writeData)
                CommandWriter.write(peripheral: peripheral, characteristic: i, commands: writeData)
                
                NotificationCenter.default.post(name: Notification.Name("write_completed"),
                                                object: nil, userInfo: nil)
                
                print("write: completed")
                break
            default:
                break
            }
        }
    }
}
