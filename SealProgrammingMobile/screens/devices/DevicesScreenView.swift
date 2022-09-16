import SwiftUI

struct DeviceScanView: View {
    @EnvironmentObject private var deviceModel :DeviceModel
    
    var onConnect: () -> Void
    
    var body: some View {
        List(){
            ForEach(deviceModel.foundPeripherals, id: \.self) { peripheral in
                FoundDeviceItem(
                    name:peripheral.name,
                    action: {
                        deviceModel.connect(peripheral: peripheral)
                        onConnect()
                    }
                )
            }
        }.onAppear(){
            deviceModel.startScan()
        }.onDisappear(){
            deviceModel.stopScan()
        }
    }
}
