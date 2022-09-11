import SwiftUI

struct DeviceScanView: View {
    @StateObject var deviceManger: DeviceManager = DeviceManager()
    
    var body: some View {
        List(){
            ForEach(deviceManger.foundPeripherals, id: \.self) { peripheral in
                FoundDeviceItem(
                    name:peripheral.name,
                    action: {
                        deviceManger.connect(peripheral: peripheral)
                    }
                )
            }
        }.onAppear(){
            deviceManger.startScan()
        }.onDisappear(){
            deviceManger.stopScan()
        }
    }
}
