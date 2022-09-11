import SwiftUI

struct DeviceScanView: View {
    @EnvironmentObject private var deviceManager :DeviceManager
    
    var onConnect: () -> Void
    
    var body: some View {
        List(){
            ForEach(deviceManager.foundPeripherals, id: \.self) { peripheral in
                FoundDeviceItem(
                    name:peripheral.name,
                    action: {
                        deviceManager.connect(peripheral: peripheral)
                        onConnect()
                    }
                )
            }
        }.onAppear(){
            deviceManager.startScan()
        }.onDisappear(){
            deviceManager.stopScan()
        }
    }
}
